; extends
(call_expression
  function: (member_expression
    object: (identifier)
    property: (property_identifier) @_name (#eq? @_name "query")
  )
  arguments: (arguments 
               ((template_string) @sql (#offset! @sql 0 1 0 -1)) 
            )
)


(call_expression
  function: (member_expression
          object: (call_expression
                    function: (member_expression
                            property: (property_identifier) @_name (#eq? @_name "query")
                                )
                    arguments: (arguments
                              ((template_string) @sql
(#offset! @sql 0 1 0 -1)) 

                                                 )
                                 )
                    )
              )


(call_expression 
  function: (member_expression
              object: (identifier) @_obj (#eq? @_obj "Prisma")
              property: (property_identifier) @_name (#eq? @_name "sql")
            ) 
  arguments: (template_string) @sql (#offset! @sql 0 1 0 -1)
  ) 

