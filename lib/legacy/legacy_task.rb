%w( order family species ).each do |filename|
  require File.join(Rails.root, "lib/legacy/models/#{filename}")
end

class LegacyTask

  class Utils
    def self.init_conv(legacy_spec, rails_spec)
      @@legacy_spec, @@rails_spec = legacy_spec, rails_spec
    end

    def self.quote_table(table)
      ActiveRecord::Base.connection.quote_table_name(table)
    end

    def self.enconv(str)
      @@legacy_spec["encoding"] != "utf-8" || @@legacy_spec["encoding"] != "unicode" ?
              Iconv.iconv('utf-8', @@legacy_spec["encoding"], str).to_s :
              str
    end
  end

  def initialize
    db_config = YAML.load_file('config/database.yml')
    @legacy_spec = db_config["legacy"]
    @rails_spec = db_config[RAILS_ENV || "development"]
    Utils.init_conv(@legacy_spec, @rails_spec)
    I18n.locale = :en
  end

  def export
    ActiveRecord::Base.establish_connection(@legacy_spec)
    
    @legacy_orders = Legacy::Order.all(:order => "ordo_id", :include => {:families => :species})
    puts "Exported #{@legacy_orders.size} orders and all their families and species\n\n"

    ActiveRecord::Base.connection.disconnect!
  end

  def import
    ActiveRecord::Base.establish_connection(@rails_spec)

		if ActiveRecord::Base.connection.respond_to?(:reset_pk_sequence!)
      %w( ordines familiae species ).each do |table_name|
        begin
          ActiveRecord::Base.connection.execute("TRUNCATE #{Utils.quote_table(table_name)}")
        rescue Exception
          ActiveRecord::Base.connection.execute("DELETE FROM #{Utils.quote_table(table_name)}")
        end
			  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
      end  
    end

    @legacy_orders.each do |order|
      puts " - Saving order #{order[:ordo_la]}"
      ordo = Ordo.create!(
              :name_la => order[:ordo_la],
              :name_en => order[:ordo_en],
              :name_ru => Utils.enconv(order[:ordo_ru]),
              :name_uk => Utils.enconv(order[:ordo_uk]),
              :description => Utils.enconv(order[:ordo_descr]),
              :synonims => Utils.enconv(order[:ordo_syn]),
              :sort => order[:ordo_id]
      )
      fam_num = 0
      order.families.each do |family|
      puts "   - Saving family #{family[:fam_la]}"
        familia = ordo.subtaxa.create!(
                :name_la => family[:fam_la],
                :name_en => family[:fam_en],
                :name_ru => Utils.enconv(family[:fam_ru]),
                :name_uk => Utils.enconv(family[:fam_uk]),
                :description => Utils.enconv(family[:fam_descr]),
                :synonims => Utils.enconv(family[:fam_syn]),
                :sort => fam_num += 1
          )
          sp_num = 0
          family.species.each do |sp|
          puts "     - Saving species #{sp[:sp_la]}"
            species = familia.subtaxa.create!(
                    :code => sp[:sp_id],
                    :name_la => sp[:sp_la],
                    :authority => sp[:sp_prim], 
                    :name_en => sp[:sp_en],
                    :name_ru => Utils.enconv(sp[:sp_ru]),
                    :name_uk => Utils.enconv(sp[:sp_uk]),
                    :description => Utils.enconv(sp[:sp_descr]),
                    :my_description => Utils.enconv(sp[:my_descr]),
                    :synonims => Utils.enconv(sp[:sp_syn]),
                    :sort => sp_num += 1
              )
          end
        
      end
    end
    puts "\nImported #{@legacy_orders.size} orders and all their families and species\n\n"
  end
  
end