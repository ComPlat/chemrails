class CreateCompounds < ActiveRecord::Migration
  def self.up
    create_table :compounds do |t|
      t.string :name
      t.string :smiles
      t.text :molfile
      
      t.integer :n_atoms
      t.integer :n_bonds
      t.integer :n_rings
      t.integer :n_QA
      t.integer :n_QB
      t.integer :n_chg
      t.integer :n_C1
      t.integer :n_C2
      t.integer :n_C
      t.integer :n_CHB1p
      t.integer :n_CHB2p
      t.integer :n_CHB3p
      t.integer :n_CHB4
      t.integer :n_O2
      t.integer :n_O3
      t.integer :n_N1
      t.integer :n_N2
      t.integer :n_N3
      t.integer :n_S
      t.integer :n_SeTe
      t.integer :n_F
      t.integer :n_Cl
      t.integer :n_Br
      t.integer :n_I
      t.integer :n_P
      t.integer :n_B
      t.integer :n_Met
      t.integer :n_X
      t.integer :n_b1
      t.integer :n_b2
      t.integer :n_b3
      t.integer :n_bar
      t.integer :n_C1O
      t.integer :n_C2O
      t.integer :n_CN
      t.integer :n_XY
      t.integer :n_r3
      t.integer :n_r4
      t.integer :n_r5
      t.integer :n_r6
      t.integer :n_r7
      t.integer :n_r8
      t.integer :n_r9
      t.integer :n_r10
      t.integer :n_r11
      t.integer :n_r12
      t.integer :n_r13p
      t.integer :n_rN
      t.integer :n_rN1
      t.integer :n_rN2
      t.integer :n_rN3p
      t.integer :n_rO
      t.integer :n_rO1
      t.integer :n_rO2p
      t.integer :n_rS
      t.integer :n_rX
      t.integer :n_rar


      t.timestamps
    end
  end

  def self.down
    drop_table :compounds
  end
end
