SELECT u.user_id, u.company_id, companies.name, COUNT(*) AS aggregate_count, (COUNT(*) / (date_part('day', age(current_timestamp, companies.created_at)) + 1)) AS activity FROM (
    SELECT events.user_id, events.company_id, events.created_at FROM events
    UNION
    SELECT messages.user_id, messages.company_id, messages.created_at FROM messages
) AS u
LEFT JOIN companies ON companies.id = u.company_id
WHERE u.company_id IS NOT NULL
GROUP BY u.user_id, u.company_id, companies.name, companies.created_at;
