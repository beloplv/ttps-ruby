#localities
Locality.create( province: 0, name: "La Plata" )
Locality.create( province: 1, name: "San Fernando del Valle de Catamarca" )
Locality.create( province: 2, name: "Resistencia" )
Locality.create( province: 3, name: "Rawson" )
Locality.create( province: 4, name: "Córdoba" )
Locality.create( province: 5, name: "Corrientes" )
Locality.create( province: 6, name: "Paraná" )
Locality.create( province: 7, name: "Formosa" )
Locality.create( province: 8, name: "San Salvador de Jujuy" )
Locality.create( province: 9, name: "Santa Rosa" )
Locality.create( province: 10, name: "La Rioja" )
Locality.create( province: 11, name: "Mendoza" )
Locality.create( province: 12, name: "Posadas" )
Locality.create( province: 13, name: "Neuquén" )
Locality.create( province: 14, name: "Viedma" )
Locality.create( province: 15, name: "Salta" )
Locality.create( province: 16, name: "San Juan" )
Locality.create( province: 17, name: "San Luis" )
Locality.create( province: 18, name: "Río Gallegos" )
Locality.create( province: 19, name: "Santa Fe" )
Locality.create( province: 20, name: "Santiago del Estero" )
Locality.create( province: 21, name: "Ushuaia" )
Locality.create( province: 22, name: "San Miguel de Tucumán" )

#branch offices
BranchOffice.create( name: "bank 1", address: "120 y 3", phone: "2215487532", locality_id: 1 )
BranchOffice.create( name: "bank 2", address: "7 y 32", phone: "2215484587", locality_id: 1 )
BranchOffice.create( name: "bank 3", address: "8 y 50", phone: "2215481111", locality_id: 1 )

#users
User.create( email: "admin1@hotmail.com", password: "123456", password_confirmation: "123456", role: 0)
User.create( email: "employee1@hotmail.com", password: "123456", password_confirmation: "123456", role: 1, branch_office_id: 1)
User.create( email: "employee2@hotmail.com", password: "123456", password_confirmation: "123456", role: 1, branch_office_id: 2)
User.create( email: "client1@hotmail.com", password: "123456", password_confirmation: "123456", role: 2)
User.create( email: "client2@hotmail.com", password: "123456", password_confirmation: "123456", role: 2)

#schedules
Schedule.create( day: 0, from: "2000-01-01 07:00:00 UTC", to: "2000-01-01 12:00:00 UTC" )
Schedule.create( day: 0, from: "2000-01-01 14:00:00 UTC", to: "2000-01-01 17:00:00 UTC" )
Schedule.create( day: 1, from: "2000-01-01 07:00:00 UTC", to: "2000-01-01 12:00:00 UTC" )
Schedule.create( day: 1, from: "2000-01-01 14:00:00 UTC", to: "2000-01-01 17:00:00 UTC" )
Schedule.create( day: 2, from: "2000-01-01 07:00:00 UTC", to: "2000-01-01 12:00:00 UTC" )
Schedule.create( day: 2, from: "2000-01-01 14:00:00 UTC", to: "2000-01-01 17:00:00 UTC" )
Schedule.create( day: 3, from: "2000-01-01 07:00:00 UTC", to: "2000-01-01 12:00:00 UTC" )
Schedule.create( day: 3, from: "2000-01-01 14:00:00 UTC", to: "2000-01-01 17:00:00 UTC" )
Schedule.create( day: 4, from: "2000-01-01 07:00:00 UTC", to: "2000-01-01 12:00:00 UTC" )
Schedule.create( day: 4, from: "2000-01-01 14:00:00 UTC", to: "2000-01-01 17:00:00 UTC" )

#branch_office with schedule
BranchOfficesSchedule.create( branch_office_id: 1, schedule_id: 1)
BranchOfficesSchedule.create( branch_office_id: 1, schedule_id: 3)
BranchOfficesSchedule.create( branch_office_id: 2, schedule_id: 1)

#turns
Turn.create( date:"2022-12-19", hour: "2000-01-01 11:30:00.000000000 +0000", motive: "cards", status: "in_progress", result: nil, branch_office_id: 1, user_id: 4, employee_id: nil)
Turn.create( date:"2022-12-19", hour: "2000-01-01 11:30:00.000000000 +0000", motive: "get money", status: "in_progress", result: nil, branch_office_id: 2, user_id: 5, employee_id: nil)
Turn.create( date:"2022-12-05", hour: "2000-01-01 09:00:00.000000000 +0000", motive: "bank loan", status: "attended", result: "accepted", branch_office_id: 2, user_id: 5, employee_id: 3)
