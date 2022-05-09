-- Resource: compute.instance_groups
CREATE TABLE IF NOT EXISTS "gcp_compute_instance_groups"
(
    "cq_id"              uuid                        NOT NULL,
    "cq_meta"            jsonb,
    "cq_fetch_date"      timestamp without time zone NOT NULL,
    "project_id"         text,
    "creation_timestamp" timestamp,
    "description"        text,
    "fingerprint"        text,
    "id"                 bigint,
    "kind"               text,
    "name"               text,
    "named_ports"        jsonb,
    "network"            text,
    "region"             text,
    "self_link"          text,
    "size"               bigint,
    "subnetwork"         text,
    "zone"               text,
    CONSTRAINT gcp_compute_instance_groups_pk PRIMARY KEY (cq_fetch_date, project_id, id),
    UNIQUE (cq_fetch_date, cq_id)
);
SELECT setup_tsdb_parent('gcp_compute_instance_groups');
CREATE TABLE IF NOT EXISTS "gcp_compute_instance_group_instances"
(
    "cq_id"                uuid                        NOT NULL,
    "cq_meta"              jsonb,
    "cq_fetch_date"        timestamp without time zone NOT NULL,
    "instance_group_cq_id" uuid,
    "instance"             text,
    "named_ports"          jsonb,
    "status"               text,
    CONSTRAINT gcp_compute_instance_group_instances_pk PRIMARY KEY (cq_fetch_date, cq_id),
    UNIQUE (cq_fetch_date, cq_id)
);
CREATE INDEX ON gcp_compute_instance_group_instances (cq_fetch_date, instance_group_cq_id);
SELECT setup_tsdb_child('gcp_compute_instance_group_instances', 'instance_group_cq_id', 'gcp_compute_instance_groups',
                        'cq_id');

