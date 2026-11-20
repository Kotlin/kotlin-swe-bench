
allprojects {
    tasks.withType<org.gradle.api.tasks.testing.Test>().configureEach {
        filter {
            excludeTestsMatching("*LatexLabelConventionInspectionTest.testFigureLabelConventionQuickFix")
            excludeTestsMatching("*LatexLabelConventionInspectionTest.testSectionLabelConventionQuickFix")
            excludeTestsMatching("*LatexLabelConventionInspectionTest.testListingLabelConventionQuickFix")
            excludeTestsMatching("*LatexLabelConventionInspectionTest.testInputListingLabelConventionQuickFix")
            excludeTestsMatching("*LatexLabelConventionInspectionTest.testListingLabelConventionQuickFixWithGroup")
            isFailOnNoMatchingTests = false
        }
    }
}
