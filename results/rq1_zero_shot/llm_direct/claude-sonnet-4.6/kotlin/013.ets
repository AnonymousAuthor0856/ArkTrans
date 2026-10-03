import { display } from '@kit.ArkUI';

// Design tokens
const AppColors = {
  primary: '#FFEF476F',
  secondary: '#FFFFD166',
  tertiary: '#FF06D6A0',
  background: '#FFFFFCF2',
  surface: '#FFFFF8E1',
  surfaceVariant: '#FFFCE7E7',
  outline: '#FFBDBDBD',
  success: '#FF06D6A0',
  warning: '#FFFFA600',
  error: '#FFD62828',
  onPrimary: '#FFFFFFFF',
  onSecondary: '#FF1F1F1F',
  onTertiary: '#FF1F1F1F',
  onBackground: '#FF1F1F1F',
  onSurface: '#FF1F1F1F',
};

interface KnobPosition {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State knobPosition: KnobPosition = { x: 140, y: 140 };
  @State knobDisplayX: number = 140;
  @State knobDisplayY: number = 140;
  private canvasSize: number = 280;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawKnob() {
    const ctx = this.canvasContext;
    const vp2px = (vp: number): number => vp * (display.getDefaultDisplaySync().densityDPI / 160);
    const sizePx = vp2px(this.canvasSize);
    ctx.clearRect(0, 0, sizePx, sizePx);

    // Draw outer ring
    ctx.beginPath();
    ctx.arc(sizePx / 2, sizePx / 2, sizePx / 2 - vp2px(20), 0, Math.PI * 2);
    ctx.strokeStyle = AppColors.secondary;
    ctx.lineWidth = vp2px(6);
    ctx.stroke();

    // Draw knob indicator
    const kx = vp2px(this.knobPosition.x);
    const ky = vp2px(this.knobPosition.y);
    ctx.beginPath();
    ctx.arc(kx, ky, vp2px(10), 0, Math.PI * 2);
    ctx.fillStyle = AppColors.primary;
    ctx.fill();
  }

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Retro Music Player')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // Main content
      Column() {
        // Knob area
        Stack() {
          Canvas(this.canvasContext)
            .width(this.canvasSize)
            .height(this.canvasSize)
            .onReady(() => {
              this.drawKnob();
            })
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  const x = event.offsetX;
                  const y = event.offsetY;
                  this.knobPosition = { x: x, y: y };
                  this.knobDisplayX = Math.round(x);
                  this.knobDisplayY = Math.round(y);
                  this.drawKnob();
                })
                .onActionUpdate((event: GestureEvent) => {
                  const x = event.offsetX;
                  const y = event.offsetY;
                  this.knobPosition = { x: x, y: y };
                  this.knobDisplayX = Math.round(x);
                  this.knobDisplayY = Math.round(y);
                  this.drawKnob();
                })
            )
        }
        .width(this.canvasSize)
        .height(this.canvasSize)
        .backgroundColor(AppColors.surface)
        .borderRadius(16)
        .border({ width: 3, color: AppColors.outline, radius: 16 })
        .clip(true)

        // Track name
        Text('Track: Summer Nights')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ top: 24 })

        // Buttons row
        Row() {
          Button('Play')
            .width(120)
            .height(48)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(12)
            .onClick(() => {})

          Button('Pause')
            .width(120)
            .height(48)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(12)
            .onClick(() => {})
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 24 })

        // Knob position label
        Text(`Knob X:${this.knobDisplayX} Y:${this.knobDisplayY}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)
          .margin({ top: 16 })

        Blank()
          .height(32)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(AppColors.background)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}