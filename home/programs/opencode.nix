_: {
  programs.opencode = {
    enable = true;
    package = null;

    rules = ./opencode/rules.md;

    agents = {
      ai-engineering = ./opencode/agents/ai_engineering.md;
      code-review = ./opencode/agents/code_review.md;
      cybersecurity = ./opencode/agents/cybersecurity.md;
      data-engineering = ./opencode/agents/data_engineering.md;
      digital-marketing = ./opencode/agents/digital_marketing.md;
      documentation = ./opencode/agents/documentation.md;
      fullstack-development = ./opencode/agents/fullstack_development.md;
      performance-engineering = ./opencode/agents/performance_engineering.md;
      product-management = ./opencode/agents/product_management.md;
      quality-assurance = ./opencode/agents/quality_assurance.md;
      systems-architecture = ./opencode/agents/systems_architecture.md;
      team-lead = ./opencode/agents/team_lead.md;
      ui-ux-design = ./opencode/agents/ui_ux_design.md;
    };

    settings = {
      autoupdate = false;
      share = "disabled";

      permission = {
        bash = "ask";
      };
    };
  };

  catppuccin.opencode = {
    enable = true;
    flavor = "mocha";
  };
}
