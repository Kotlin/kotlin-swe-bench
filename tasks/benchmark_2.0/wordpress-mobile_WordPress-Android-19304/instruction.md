# Implement the issue(s) in wordpress-mobile/WordPress-Android:

## Issue: Plans in Site Creation: Integrate Plan selection into Site Creation flow

## Description

Integrate Plan selection into Site Creation flow

Requirements:
1. Enable flow: Theme Selection -> Domain Selection -> **Plan Selection** -> Site Assembly -> **Checkout**
2. Use the Plan selection view and display on a web view: `wordpress.com/jetpack-app-plans/`
4. If paid domain is selected, pass `paid_domain_name` parameter. Example: `paid_domain_name=domainname.com`
5. If paid plan is selected, the original URL will redirect with  `plan_id` and `plan_slug` parameters. Example: `wordpress.com/jetpack-app/plans?plan_id=1009&plan_slug=personal_bundle`
6. Add the selected paid plan to the cart using `plan_id`
7. If free plan is selected, the original URL will redirect with `plan_slug=free_plan` parameter without a `plan_id`.Example: `wordpress.com/jetpack-app/plans?plan_slug=free_plan`
8. Don't include paid domain into the cart if free plan is selected
9. If paid plan + domain is added to the cart, present Checkout after Site Assembly

## Interface

The tests use these declarations:

- `org.wordpress.android.ui.sitecreation.plans.PlanModel(Int?, String?, String?, isCurrentPlan: Boolean, hasDomainCredit: Boolean)`
- `plan: PlanModel?`, a constructor property of `org.wordpress.android.ui.sitecreation.SiteCreationState`, with a default
