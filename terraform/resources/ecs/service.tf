resource "aws_ecs_task_definition" "web" {
    family                   = "${var.ecs_task_definition_name}"
    container_definitions    = <<DEFINITION
[
    {
        "name": "backend",
        "image": "${var.ecr_url}:0.2",
        "memory": 256,
        "portMappings": [
            {
                "containerPort": ${var.ecs_service_container_port},
                "hostPort": ${var.ecs_service_container_port}
            }
        ],
        "environment": [
            {
                "name": "DBHOST",
                "value": "${var.database_url}"
            },
            {
                "name": "DBNAME",
                "value": "${var.database_name}"
            },
            {
                "name": "DBPASS",
                "value": "${var.database_pass}"
            },
            {
                "name": "DBUSER",
                "value": "${var.database_user}"
            }
        ]
    }
]
DEFINITION
    requires_compatibilities = ["${var.ecs_service_launch_type}"]
    network_mode             = "bridge"
}
resource "aws_ecs_service" "web" {
    name            = "${var.ecs_service_name}"
    task_definition = "${aws_ecs_task_definition.web.arn}"
    desired_count   = "${var.ecs_service_desired_count}"
    launch_type     = "${var.ecs_service_launch_type}"
    cluster         = "${aws_ecs_cluster.cluster.id}"

    load_balancer {
        target_group_arn = "${var.target_group_arn}"
        container_name   = "${var.ecs_service_container_name}"
        container_port   = "${var.ecs_service_container_port}"
    }
}