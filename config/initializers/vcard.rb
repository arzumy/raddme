module Vpim
  class Vcard
    def Vcard.create(fields = [] )
      fields.unshift Field.create('VERSION', "2.1")
      super(fields, 'VCARD')
    end
  end
end