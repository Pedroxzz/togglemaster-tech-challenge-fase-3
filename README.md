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
