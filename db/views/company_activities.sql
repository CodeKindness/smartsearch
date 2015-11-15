SELECT
	companies.user_id,
	companies.id,
	companies.slug,
	companies.name,
	(COUNT(u.*) / (ABS((EXTRACT(epoch FROM (current_timestamp - companies.created_at))) / 86400)) * 100) AS activity
FROM companies
LEFT JOIN (
    SELECT events.user_id, events.company_id, events.created_at FROM events
    UNION
    SELECT messages.user_id, messages.company_id, messages.created_at FROM messages
) AS u ON companies.id = u.company_id
GROUP BY companies.id, companies.user_id, companies.name, companies.created_at
ORDER BY activity DESC;
