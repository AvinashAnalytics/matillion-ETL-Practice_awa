-- Check available stages in Snowflake
SELECT 
    stage_name,
    stage_schema,
    stage_type,
    stage_url,
    comment
FROM information_schema.stages 
WHERE stage_catalog = 'MATILLION'
ORDER BY stage_name;

-- Also check if we can create a simple stage for testing
SHOW STAGES IN SCHEMA MATILLION.STAGE;