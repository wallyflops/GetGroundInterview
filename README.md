Hi!

<h1> How to use</h1>

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

<h1>schema.yml</h1>
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



<h1>Tests</h1>
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

I would make sure that every field has a description, and every field has relevant tests in a real life example, but this would be very time consuming for this example so I have skipped doing this!

<h1>How I've structured the project</h1>
I've created a folder structure of "landing", "base" and "analytics".
**landing**
landing is where the data enters the project, I've made effort to not do too much transformations at this stage. Renaming fields and preparing the data ready for analysis.

**base**
Base is where I'm doing my main transformations. I've created a table which should allow analysts to really interrogate this data. You could put this into a BI tool like Looker and really explore this data in this state.

**analytics**
Here is where I may prepare more specific analytics which could be imported into tableau, or maybe Looker too.


<h1>My findings & thoughts</h1>
The date format is a little strange, I would suggest storing this at a much higher level of granularity, say date, or hour. Nanoseconds may be a little bit too much!

<h2>Output queries </h2>

Please see ```models/analytics/analytics_time``` the goal of this query is to work out if there's some reason certain referrals are quicker, this could be used to analyse are certain countries better, certain companies or people converting faster/slower?

please see: ```models/analytics/analytics_top_countries``` I am demonstrating the use of: ```count( case when is_outbound = 1 then rc.referral_id end ) as num_of_outbound_referrals``` casing within an aggregation
and also ```dense_rank() over (order by total_referrals desc) as ranked``` making use of window functions, you could also use a partition by to aggregate this on another granularity.

please see: ```models/analytics/analytics_upsell``` for a view of our 'upsellers' as detailed in your readme instructions.


<h2>If I had more time/Improvements</h2>

* If I had more time I would have liked to analyse the time to referral a bit more, we could have baked this into the 'base' layer or could maybe keep a history table here to analyse how these referrals change over time.

* Also, I would not usually do my analysis in SQL, I have done a bit to showcase my use of SQL, but I would be much more comfortable putting something into Looker/Tableau etc and really playing with the data there. Spotting trends over time, and gaps in data is much easier in this setting. I am hoping that I've demonstrated these skills in SQL though.

* Finally I have not included .YML files with the analytics layer, mostly due to time constraints, in a professional project every SQL file would be fully documented in a yml file.




