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
#(1, 'Gaviiformes', '��������������', '', '�����������', '', ''),
#(2, 'Podicipediformes', '���������������', '', 'ϳ������������', '', ''),
#(3, 'Procellariiformes', '��������������������', '', '���������������', '', ''),
#(4, 'Pelecaniformes', '����������������', '', '������������', '', ''),
#(5, 'Ciconiiformes', '�������������', '', '�����������', '����������, ��������', ''),
#(6, 'Phoenicopteriformes', '����������������', '', '������������', '', ''),
#(7, 'Anseriformes', '������������', '', '���������', '', ''),
#(8, 'Falconiformes', '��������������', '', '�����������', '', ''),
#(9, 'Galiiformes', '������������', '', '���������', '', ''),
#(10, 'Gruiformes', '���������������', '', '������������', '', ''),
#(11, 'Charadriiformes', '��������������', '', '����������', '', ''),
#(12, 'Columbiformes', '��������������', '', '�����������', '', ''),
#(13, 'Cuculiformes', '���������������', '', '�����������', '', ''),
#(14, 'Psittaciformes', '���������������', '', '�����������', '', ''),
#(15, 'Strigiformes', '������������', '', '���������', '', ''),
#(16, 'Apodiformes', '��������������', '', '�����������������', '', ''),
#(17, 'Caprimulgiformes', '���������������', '', '������������', '', ''),
#(18, 'Upupiformes', '�������������', '', '����������', '', '������ ���������� � ��������� <a href="/aves/coraciiformes/">�������������</a>.'),
#(19, 'Coraciiformes', '�������������', '', '����������', '', ''),
#(20, 'Piciformes', '�������������', '', '����������', '', ''),
#(21, 'Passeriformes', '�����������������', '', '������������', '', '');
