Hur vi designar vår databas.

1st normal form

Alla rader måste vara unika och varje cell måste innehålle atomic values.

- Alla rader(rows) måste vara unika
    
    - Primary key
  
- Varje cell får endast innehålla ett värde
 
```
    ! Address: silvermyntsgatan 24, 414 79, Göteborg
    = Streetname: silvermyntsgatan
    = streetnumber: 24'
```

- Varje själv ska inte kunna gå att dividera

```
    ! name: "Alexis Flach"
    = "firstName: "Alexis", "lastName": "Flach"
```

2nd normal form

No partial Dependencies
All non-prime attributes should be fully functionally dependent on the candidate key.

3rd normal form
No transitive dependency - All fields msut only be determinable by the primary/composite key, not by other keys


