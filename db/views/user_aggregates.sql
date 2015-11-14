SELECT u.user_id, u.company_id, u.contact_id, u.aggregateable_id, u.aggregateable_type, u.slug, u.created_at, u.start_at, u.end_at, u.read_at, u.event_type, u.highlight_color, u.description, u.workflow_state FROM (
    SELECT events.user_id, events.company_id, events.contact_id, events.id AS aggregateable_id, 'Event' AS aggregateable_type, events.slug, events.created_at, events.start_at, events.end_at, NULL AS read_at, event_types.name AS event_type, event_types.highlight_color, events.description, NULL AS workflow_state FROM events LEFT JOIN event_types ON event_types.id = events.event_type_id
    UNION
    SELECT messages.user_id, messages.company_id, messages.contact_id, messages.id AS aggregateable_id, 'Message' AS aggregateable_type, messages.slug, messages.created_at, messages.originated_at AS start_at, NULL AS end_at, messages.read_at, 'Message' AS event_type, NULL AS highlight_color, messages.subject AS description, messages.workflow_state FROM messages
) AS u
ORDER BY u.start_at DESC;
