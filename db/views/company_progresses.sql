SELECT companies.id, companies.user_id, companies.slug, companies.name, COALESCE(user_aggregates.event_type, 'Pending') AS event_type, COUNT(user_aggregates.event_type) FROM companies
LEFT JOIN user_aggregates ON user_aggregates.company_id = companies.id
GROUP BY user_aggregates.event_type, companies.name, companies.id
