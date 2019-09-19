resource "aws_cloudwatch_log_group" "service" {
  count             = "${var.create ? 1 : 0}"
  name              = var.log_group
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "service" {
  count                 = "${var.create ? 1 : 0}"
  family                = var.name
  container_definitions = var.container_def
  memory                = var.memory
  cpu                   = var.cpu
}

resource "aws_ecs_service" "service-elb" {
  count                             = "${var.create && var.use_elb ? 1 : 0}"
  name                              = var.name
  cluster                           = var.cluster_id
  task_definition                   = aws_ecs_task_definition.service[count.index].arn
  health_check_grace_period_seconds = var.elb_health_check_grace_period
  load_balancer {
    elb_name       = var.elb_name
    container_name = var.name
    container_port = var.elb_port
  }

  desired_count = 1

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}

resource "aws_ecs_service" "service-alb" {
  count                             = "${var.create && var.use_alb ? 1 : 0}"
  name                              = var.name
  cluster                           = var.cluster_id
  task_definition                   = aws_ecs_task_definition.service[count.index].arn
  health_check_grace_period_seconds = var.elb_health_check_grace_period
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.name
    container_port   = var.elb_port
  }

  desired_count = 1

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}

