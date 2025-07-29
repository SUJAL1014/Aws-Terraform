terraform {}

#Number list
variable "num_list" {
  type    = list(number)
  default = [1, 2, 3, 4, 5]
}

#Object list of person
variable "person_list" {
  type = list(object({
    fname = string
    lname = string
  }))
  default = [{
    fname = "Raju"
    lname = "Kumar"
    }, {
    fname = "Ravi"
    lname = "Sharma"
  }]
}

variable "map_list" {
  type = map(number)
  default = {
    "one"   = 1
    "two"   = 2
    "three" = 3
  }

}

#Calculation
locals {
  mul = 2*8
  add = 2 + 2
  eq = 2 != 3

  #double
  double = [for i in var.num_list : i * 2]

  #odd number only
  odd = [for i in var.num_list : i if i % 2 !=0]

  #To get the first element of person_list
  fname_list = [for i in var.person_list : i.fname]

  #work with map
  mapinfo = [for k, v in var.map_list: v*3]

  doublemap ={for k,v  in var.map_list: k=> v*2}
}

output "output" {
    value = local.doublemap
}
