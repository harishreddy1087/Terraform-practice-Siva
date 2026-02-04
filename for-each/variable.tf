variable "instances" {
    # Sign ({ }) == Maps always use curly braces. (Lists use square brackets [ ]).
  type = map(string)
  default = {
    "mysql" = "t2.micro"
    "db"    = "t3.micro"
    "fnt"   = "t2.micro"
  }

}