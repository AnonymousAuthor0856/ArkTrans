import { AppColors, AppTypography, AppShapes, AppSpacing, AppElevation } from '../common/AppTokens';

@Entry
@Component
struct RootScreen {
  @State knobX: number = 90;
  @State knobY: number = 140;
  @State powerOn: boolean = false;

  private dragOriginX: number = 90;
  private dragOriginY: number = 140;

  private bound(value: number): number {
    const half: number = AppShapes.knobRadius;
    const maxPos: number = AppShapes.knobSurfaceSize - half;
    return Math.min(maxPos, Math.max(half, value));
  }

  @Builder
  RoundButton(label1: string, label2: string, bg: string, fg: string, onTap: () => void) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Column({ space: 0 }) {
        Text(label1)
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(fg)
        if (label2.length > 0) {
          Text(label2)
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(fg)
        }
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(AppShapes.buttonSize)
    .height(AppShapes.buttonSize)
    .backgroundColor(bg)
    .onClick(onTap)
  }

  build() {
    Column() {
      Row().width('100%').height(40)

      Stack() {
        Text('Retro Remote Control')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.xl }) {
          Stack({ alignContent: Alignment.TopStart }) {
            Circle()
              .width(AppShapes.trackDiameter)
              .height(AppShapes.trackDiameter)
              .fill(AppColors.secondary)
              .opacity(0.2)
              .position({
                x: (AppShapes.knobSurfaceSize - AppShapes.trackDiameter) / 2,
                y: (AppShapes.knobSurfaceSize - AppShapes.trackDiameter) / 2
              })

            Circle()
              .width(AppShapes.knobDiameter)
              .height(AppShapes.knobDiameter)
              .fill(AppColors.primary)
              .position({ x: this.knobX - AppShapes.knobRadius, y: this.knobY - AppShapes.knobRadius })
          }
          .width(AppShapes.knobSurfaceSize)
          .height(AppShapes.knobSurfaceSize)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.largeRadius)
          .clip(true)
          .shadow({
            radius: AppElevation.level1.radius,
            color: AppColors.shadow12,
            offsetX: 0,
            offsetY: AppElevation.level1.dy
          })
          .margin(AppSpacing.lg)
          .gesture(
            PanGesture({ fingers: 1, direction: PanDirection.All, distance: 1 })
              .onActionStart(() => {
                this.dragOriginX = this.knobX;
                this.dragOriginY = this.knobY;
              })
              .onActionUpdate((event: GestureEvent) => {
                this.knobX = this.bound(this.dragOriginX + event.offsetX);
                this.knobY = this.bound(this.dragOriginY + event.offsetY);
              })
          )

          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(this.powerOn ? AppColors.success : AppColors.error)

          Row({ space: AppSpacing.buttonGap }) {
            this.RoundButton('On', '', AppColors.primary, AppColors.onPrimary, () => {
              this.powerOn = !this.powerOn;
            })

            this.RoundButton('Res', 'et', AppColors.secondary, AppColors.onSecondary, () => {
              this.knobX = 90;
              this.knobY = 140;
            })
          }

          Column() {
            Row()
              .width('100%')
              .height(AppShapes.progressHeight)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.progressHeight / 2)
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        }
        .width('100%')
        .padding(AppSpacing.lg)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}