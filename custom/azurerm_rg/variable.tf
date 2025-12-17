variable "rg_list" {
    type = map(object({
                name = string
        location = string
        tags =  map(string)
    }))
}