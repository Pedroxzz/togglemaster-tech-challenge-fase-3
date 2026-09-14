# ToggleMaster - Tech Challenge Fase 3

Este repositório reúne a entrega completa da Fase 3 do Tech Challenge, incluindo infraestrutura AWS, automação de entrega, manifests GitOps e os microsserviços do projeto transferidos da Fase 2.

## Visão geral

A Fase 3 do projeto foi organizada como um repositório dedicado à infraestrutura e ao deploy automatizado do ToggleMaster. Aqui ficam:

- código Terraform para provisionamento da infraestrutura AWS
- módulos reutilizáveis para networking, EKS, serviços de dados e ECR
- manifests Kubernetes para GitOps
- pipeline CI/CD com GitHub Actions
- código-fonte dos microsserviços do projeto
- documentação e estrutura de execução para a entrega da solução

## Objetivos da Fase 3

1. Provisionar VPC, EKS, RDS Aurora, ElastiCache Redis, DynamoDB, SQS e ECR via Terraform.
2. Estruturar um pipeline de CI/CD com build, test, scan de segurança e push de imagens.
3. Preparar manifests Kubernetes para deploy GitOps.
4. Centralizar a infraestrutura e a automação em um repositório separado dos microsserviços.

## Estrutura atual do repositório

```txt
.
├── .env
├── .github/
│   └── workflows/
│       └── ci-devsecops.yml
├── .gitignore
├── analytics-service/
├── auth-service/
├── docker-compose.yaml
├── docs/
├── evaluation-service/
├── flag-service/
├── gitops/
│   ├── apps/
│   │   ├── analytics-service.yaml
│   │   ├── auth-service.yaml
│   │   ├── evaluation-service.yaml
│   │   ├── flag-service.yaml
│   │   ├── namespace.yaml
│   │   └── targeting-service.yaml
│   └── argocd/
│       ├── application.yaml
│       └── install-argocd.yaml
├── k8s/
├── output/
├── targeting-service/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── versions.tf
│   ├── .terraform.lock.hcl
│   ├── .terraform/
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   └── modules/
│       ├── data-services/
│       ├── ecr/
│       ├── eks/
│       └── networking/
├── README.md
└── .gitignore
```

## O que já foi implementado

### Microsserviços e artefatos transferidos da Fase 2

Os seguintes diretórios foram transferidos para a Fase 3 e passam a fazer parte do repositório de entrega:

- `analytics-service`
- `auth-service`
- `evaluation-service`
- `flag-service`
- `targeting-service`
- `docs`
- `k8s`
- `output`
- `docker-compose.yaml`

### Infraestrutura Terraform

Os seguintes módulos já foram estruturados em Terraform:

- `terraform/modules/networking`
  - VPC
  - subnets públicas e privadas
  - internet gateway
  - route tables

- `terraform/modules/data-services`
  - RDS Aurora PostgreSQL
  - ElastiCache Redis
  - DynamoDB para analytics
  - SQS para fila de eventos

- `terraform/modules/eks`
  - IAM role para cluster
  - IAM role para node group
  - EKS cluster
  - EKS node group

- `terraform/modules/ecr`
  - repositorios ECR para os 5 serviços

### Pipeline CI/CD

O workflow em `.github/workflows/ci-devsecops.yml` já contempla:

- checkout do código
- setup do ambiente por linguagem
- instalação de dependências
- build/test por serviço
- scan de segurança com Trivy, Gosec e Bandit
- build e push das imagens para ECR
- atualização de tags para GitOps

### GitOps

A pasta `gitops/apps` já contém manifests para:

- namespace
- auth-service
- flag-service
- targeting-service
- evaluation-service
- analytics-service

A pasta `gitops/argocd` já contém:

- instalação do ArgoCD
- aplicação para sincronização do repositório GitOps

## Status atual do projeto

### Concluído

- base do repositório Fase 3 criada
- estrutura Terraform inicial implementada
- módulos de infraestrutura criados
- manifests GitOps criados
- pipeline GitHub Actions criado
- `terraform init` executado com sucesso
- `terraform validate` executado com sucesso
- `terraform plan` mostrou 36 recursos a serem criados

### Pendências de execução real

- autenticação/autorizações AWS corretas para o ambiente
- ajuste de versão EKS / AMI do node group para compatibilidade com a região
- `terraform apply` para provisionar recursos reais na AWS
- atualização do kubeconfig e validação do cluster
- deploy dos manifests no cluster
- sincronização via ArgoCD
- validação funcional dos serviços na AWS

## Variáveis e secrets importantes

O Terraform usa valores em `terraform/variables.tf`, incluindo:

- `aws_region`
- `project_name`
- `environment`
- `vpc_cidr`
- `public_subnets`
- `private_subnets`
- `availability_zones`
- `eks_cluster_version`
- `eks_node_instance_type`
- `eks_node_*` para scaling
- credenciais de banco

Para o GitHub Actions, os secrets esperados são:

```bash
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
```

Se a conta for AWS Academy, normalmente o uso de `LabRole` será necessário e a automação deve ser ajustada ao ambiente específico.

## Fluxo recomendado

1. Ajustar credenciais AWS e permissões.
2. Validar o plan do Terraform.
3. Executar o `terraform apply`.
4. Configurar `aws eks update-kubeconfig`.
5. Validar cluster e nós via `kubectl`.
6. Aplicar manifests do GitOps.
7. Validar deploy dos serviços.
8. Validar pipeline CI/CD com push de imagens para ECR.

## Observações importantes

- Este repositório agora reúne a infraestrutura, a automação de entrega, os manifests GitOps e o código dos microsserviços da Fase 2.
- A estrutura foi atualizada para refletir o handoff completo da solução, deixando o projeto pronto para continuidade por outra pessoa ou equipe.
- Em alguns momentos da execução, a AWS exigiu ajustes de autenticação, permissões e compatibilidade de versão do EKS, então esses pontos precisam ser validados antes do deploy final.

## Próximo passo da entrega

O próximo bloco de trabalho principal é:

1. corrigir a autenticação da AWS e a autorização da conta
2. ajustar a versão/AMI do EKS para um padrão suportado
3. finalizar o `terraform apply`
4. conectar o cluster e aplicar os manifests do GitOps
5. validar a aplicação completa no ambiente AWS
6. remover a pasta antiga da Fase 2 após a validação final do handoff
