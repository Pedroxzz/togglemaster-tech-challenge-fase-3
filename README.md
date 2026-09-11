# ToggleMaster - Tech Challenge Fase 3

Este repositório foi criado para a Fase 3 do Tech Challenge, com foco em:

- Infraestrutura como Código em Terraform
- DevSecOps com GitHub Actions
- GitOps com ArgoCD
- Implantação de 5 microsserviços do ToggleMaster

## Estrutura

```txt
.
├── .github/
│   └── workflows/
├── terraform/
│   ├── modules/
│   │   ├── networking/
│   │   ├── data-services/
│   │   ├── eks/
│   │   └── ecr/
│   ├── main.tf
│   ├── variables.tf
│   ├── versions.tf
│   └── outputs.tf
├── gitops/
│   ├── apps/
│   └── argocd/
├── docs/
├── README.md
└── .gitignore
```

## Objetivos

1. Provisionar VPC, EKS, RDS, ElastiCache, DynamoDB, SQS e ECR via Terraform.
2. Criar pipelines CI com build, lint, segurança e scan de imagem.
3. Implementar deploy GitOps com ArgoCD sincronizando manifests.
4. Organizar a entrega de forma reusável e automatizada.

## Componentes provisionados

- VPC com subnets públicas e privadas
- Cluster EKS com node group
- RDS Aurora PostgreSQL
- ElastiCache Redis
- DynamoDB para analytics
- SQS para eventos
- ECR com os 5 repositórios

## Secrets do GitHub Actions

No GitHub, configure os secrets do repositório:

```bash
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
```

Se a conta for AWS Academy, normalmente a LabRole será usada no Terraform e o acesso pode ser ajustado de acordo com a política do ambiente.

## GitOps

A pasta `gitops/apps` contém os manifests Kubernetes dos microsserviços, enquanto `gitops/argocd` define a aplicação monitorada pelo ArgoCD.

## Próximo passo

1. Ajustar as credenciais AWS reais do ambiente.
2. Conectar o repositório GitOps ao ArgoCD.
3. Fazer o primeiro `terraform plan` e `terraform apply`.
4. Validar a sincronização do ArgoCD na EKS.
