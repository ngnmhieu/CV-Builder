# Components of a template

Two main files that correspond to the <head> and <body> of HTML page: 
```
resume_head.liquid # contains css
resume_body.liquid # contains the overall content
```

Templates for the components of a Resume:
```
_personal_detail.liquid # Personal informations (always stays on top)
_simplelist.liquid      # List with short / one-line items
_worklist.liquid        # List represents work-like informations 
                        #   like Work Experiences, Educations, ...
_textsection.liquid     # A simple paragraph
```

