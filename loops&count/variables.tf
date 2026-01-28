variable "instance_names" {
    # Use list(string) For an ordered collection of values
    type = list(string)
    default = [ "mysql", "backend", "frontend" ]

}