Hi!

Feel free to run the project with:
```dbt run -s landing base analytics```

And to run the tests with:
```dbt test -s landing base analytics```
**dbt_project.yml**
```
models:
  landing:
    # Applies to all files under models/example/
    materialized: table
  base:
    materialized: table
  analysis:
    materialized: table
```
I am using table's here mainly for simplicity, in a real life example I may use views, or even ephemeral's.

**schema.yml**
In here I am adding our sources which I have manually imported into BQ. I did this via GCP Storage.

```
version: 2
sources:
    - name: getground
      description: 'This is a description'
      # database: landing

      schema: getgroundsample
      tables:
        - name: 'sales_people'
          identifier: 'sales_people'
        - name: 'partners'
          identifier: 'partners'
        - name: 'referrals'
          identifier: 'referrals'
```



**Tests**
I have included an example of referential integrity in the file: 
```landing_referrals.yml```

it is done like so:
```
models:
      columns:
        - name: partner_id
          description: this is the ID of the partner
          tests:
            - relationships:
                to: ref('landing_partners')
                field: partner_id
```
I have done some more simple tests in the ```partners.yml``` file:
```
        tests:
          - not_null
          - unique
      - name: partner_type
        description: 'This is the type of partner we have'
        tests:
          - accepted_values:
              values: ['Lender', 'Insurer', 'Other', 'Agent', 'IFA', 'Developer', 'Influencer', 'Management company']
```




