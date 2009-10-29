class CreateOrdines < ActiveRecord::Migration
  def self.up
    create_table :ordines do |t|
      t.string :name_la, :null => false, :limit => 128
      t.string :name_en, :limit => 128
      t.string :name_ru, :null => false, :limit => 128
      t.string :name_uk, :null => false, :limit => 128
      t.text :description
      t.string :synonims, :limit => 256
      t.integer :sort, :null => false
    end
    add_index "ordines", ["name_la"], :name => "ordines_name_la"
    add_index "ordines", ["sort"], :name => "ordines_sort"
  end

  def self.down
    drop_table :ordines
  end
end


#INSERT INTO `ordines` (`sort`, `name_la`, `name_ru`, `name_en`, `name_uk`, `synonims`, `description`) VALUES
#(1, 'Gaviiformes', 'Гагарообразные', '', 'Гагароподібні', '', ''),
#(2, 'Podicipediformes', 'Поганкообразные', '', 'Пірникозоподібні', '', ''),
#(3, 'Procellariiformes', 'Буревестникообразные', '', 'Буревісникоподібні', '', ''),
#(4, 'Pelecaniformes', 'Пеликанообразные', '', 'Пеліканоподібні', '', ''),
#(5, 'Ciconiiformes', 'Аистообразные', '', 'Лелекоподібні', 'Голенастые, Голенасті', ''),
#(6, 'Phoenicopteriformes', 'Фламингообразные', '', 'Фламінгоподібні', '', ''),
#(7, 'Anseriformes', 'Гусеобразные', '', 'Гусеподібні', '', ''),
#(8, 'Falconiformes', 'Соколообразные', '', 'Соколоподібні', '', ''),
#(9, 'Galiiformes', 'Курообразные', '', 'Куроподібні', '', ''),
#(10, 'Gruiformes', 'Журавлеобразные', '', 'Журавлеподібні', '', ''),
#(11, 'Charadriiformes', 'Ржанкообразные', '', 'Сивкоподібні', '', ''),
#(12, 'Columbiformes', 'Голубеобразные', '', 'Голубоподібні', '', ''),
#(13, 'Cuculiformes', 'Кукушкообразные', '', 'Зозулеподібні', '', ''),
#(14, 'Psittaciformes', 'Попугаеобразные', '', 'Папугоподібні', '', ''),
#(15, 'Strigiformes', 'Совообразные', '', 'Совоподібні', '', ''),
#(16, 'Apodiformes', 'Стрижеобразные', '', 'Серпокрильцеподібні', '', ''),
#(17, 'Caprimulgiformes', 'Козодоеобразные', '', 'Дрімлюгоподібні', '', ''),
#(18, 'Upupiformes', 'Удодообразные', '', 'Одудоподібні', '', 'Иногда включаются в семейство <a href="/aves/coraciiformes/">Ракшеобразных</a>.'),
#(19, 'Coraciiformes', 'Ракшеобразные', '', 'Ракшеподібні', '', ''),
#(20, 'Piciformes', 'Дятлообразные', '', 'Дятлоподібні', '', ''),
#(21, 'Passeriformes', 'Воробьинообразные', '', 'Горобцеподібні', '', '');
