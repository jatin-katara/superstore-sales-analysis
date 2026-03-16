select*from superstore_sales_analysis;

create view category_sales_view as 
select category, sum(sales) as totals_sales
from superstore_sales_analysis
group by category;

select * from category_sales_view;

create view region_sales_view as 
select region, sum(sales) as total_sales
from superstore_sales_analysis
group by region 
order by total_sales desc;

select * from region_sales_view;

create view top_products_view as 
select "Product Name", sum(sales) as total_sales
from superstore_sales_analysis 
group by "Product Name"
order by total_sales desc
limit 10;

select * from top_products_view;

select 
category,
"Product Name",
sum(sales) as total_sales,
rank() over(
             partition by category
             order by sum(sales) desc
             ) as product_rank
             from superstore_sales_analysis
             group by category, "Product Name";

select * from (select 
category, "Product Name",
sum(sales) as total_sales,
rank() over (partition by category order 
by sum(sales)desc) as product_rank
from superstore_sales_analysis
group by category, "Product Name")
ranked_products
where product_rank <= 3;

select 
to_date("Order Date",'MM/DD/YYYY') as order_date,
sales 
from superstore_sales_analysis 
limit 5;

select 
date_trunc('month', to_date("Order Date",'DD/MM/YYYY')) as month,
sum(sales) as total_sales
from superstore_sales_analysis
group by month
order by month;            


CREATE VIEW monthly_sales_view AS
SELECT
DATE_TRUNC('month', TO_DATE("Order Date", 'DD/MM/YYYY')) AS month,
SUM(sales) AS total_sales
FROM superstore_sales_analysis
GROUP BY month
ORDER BY month;

select*from monthly_sales_view;