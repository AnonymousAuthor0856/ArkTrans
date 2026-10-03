// ============================================================
// File: pages/Index.ets
// RootScreen —— 对应 SwiftUI 的 RootScreen + AfterSaleServiceApp
// ============================================================

import { AppColors, AppSpacing, AppShapes, AppTypography, ElevationMapping } from '../common/AppTokens';

@Entry
@Component
struct RootScreen {
  @State orderId: string = '';
  @State issue: string = '';
  @State submitted: boolean = false;
  @State orderIdIsFocused: boolean = false;
  @State issueIsFocused: boolean = false;

  build() {
    Column({ space: AppSpacing.lg }) {
      // 标题
      Text('After-Sale Service')
        .fontSize(AppTypography.display.size)
        .fontWeight(AppTypography.display.weight)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)

      // Card：填充宽度 + 圆角 + 白色底 + level2 阴影
      Column({ space: AppSpacing.md }) {
        Text('Order ID')
          .fontSize(AppTypography.title.size)
          .fontWeight(AppTypography.title.weight)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Order ID 输入框（容器色恒定，边框随焦点变化）
        TextInput({ placeholder: 'Enter order number', text: this.orderId })
          .type(InputType.Normal)
          .fontSize(AppTypography.body.size)
          .fontWeight(AppTypography.body.weight)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.onSurface50)
          .placeholderFont({ size: AppTypography.body.size, weight: AppTypography.body.weight })
          .caretColor(AppColors.primary)
          .height(56)
          .width('100%')
          .padding({ left: AppSpacing.md, right: AppSpacing.md })
          .backgroundColor(AppColors.surfaceVariant)
          .border({
            width: 1,
            color: this.orderIdIsFocused ? AppColors.primary : AppColors.outline,
            radius: AppShapes.medium
          })
          .borderRadius(AppShapes.medium)
          .onChange((value: string) => {
            this.orderId = value;
          })
          .onFocus(() => {
            this.orderIdIsFocused = true;
          })
          .onBlur(() => {
            this.orderIdIsFocused = false;
          })

        Text('Issue Description')
          .fontSize(AppTypography.title.size)
          .fontWeight(AppTypography.title.weight)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Issue Description 多行输入框
        TextArea({ placeholder: 'Describe your issue', text: this.issue })
          .fontSize(AppTypography.body.size)
          .fontWeight(AppTypography.body.weight)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.onSurface50)
          .placeholderFont({ size: AppTypography.body.size, weight: AppTypography.body.weight })
          .caretColor(AppColors.primary)
          .height(120)
          .width('100%')
          .padding({
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.sm + 4,
            bottom: AppSpacing.sm + 4
          })
          .backgroundColor(AppColors.surfaceVariant)
          .border({
            width: 1,
            color: this.issueIsFocused ? AppColors.primary : AppColors.outline,
            radius: AppShapes.medium
          })
          .borderRadius(AppShapes.medium)
          .onChange((value: string) => {
            this.issue = value;
          })
          .onFocus(() => {
            this.issueIsFocused = true;
          })
          .onBlur(() => {
            this.issueIsFocused = false;
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.large)
      .shadow({
        radius: ElevationMapping.level2.radius,
        color: AppColors.outlineShadow22,
        offsetX: 0,
        offsetY: ElevationMapping.level2.dy
      })

      // 提交按钮
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Submit Request')
          .fontSize(AppTypography.title.size)
          .fontWeight(AppTypography.title.weight)
          .fontColor(AppColors.onPrimary)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.large)
      .onClick(() => {
        this.submitted = true;
      })

      // 提交成功提示
      if (this.submitted) {
        Text('Request submitted successfully!')
          .fontSize(AppTypography.body.size)
          .fontWeight(AppTypography.body.weight)
          .fontColor(AppColors.success)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.success15)
          .borderRadius(AppShapes.medium)
      }
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}