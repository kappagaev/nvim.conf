; extends

; (call_expression 
;   function: (member_expression
;               object: (identifier) @_obj (#eq? @_obj "prisma")
;               property: (property_identifier) @_name (#eq? @_name "$queryRaw")
;             ) 
;   arguments: (template_string) @injection.content (#set! injection.language "sql") 
;   ) 
;
;
; (call_expression 
;   function: (member_expression
;               object: (identifier) @_obj (#eq? @_obj "Prisma")
;               property: (property_identifier) @_name (#eq? @_name "sql")
;             ) 
;   arguments: (template_string) @injection.content (#set! injection.language "sql") 
;   ) 
;
