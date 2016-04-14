# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Usuario.create!(email: "kevin@gmail.com", password:"kevinverde", username: "kevinverde")
Contribuyente.create!(nit: "3879309", nombre: "Kevin Jimenez", calle: "2 calle", no_casa: "1-90", zona: "2", colonia: "Escuintla", departamento: "Escuintla", municipio: "Escuintla", telefono: "44267590")
Establecimiento.create!(nombre: "Casa kevin", calle: "2 calle", numero_casa: "1-90", zona: "1", colonia: "Escuintla", departamento: "Escuintla", municipio: "Escuintla", telefono: "44267590", contribuyente_id: 1)