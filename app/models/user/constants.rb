class User < ApplicationRecord

ROLES =[
  	[:registered, 1],
  	[:banned, 2],	
  	[:moderator, 3],
  	[:admin, 4]
  ]

end