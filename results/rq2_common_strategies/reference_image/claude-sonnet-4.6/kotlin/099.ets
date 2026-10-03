// entry/src/main/ets/pages/Index.ets
import window from '@ohos.window';
import { BusinessError } from '@ohos.base';

// --- Theme tokens (mirrors the Compose color literals) ---
const MATCHA_GREEN: string = '#556B2F'; // Dark olive green, primary
const BOWL_DARK: string = '#333333';    // Charcoal bowl
const MATCHA_BRIGHT: string = '#8BBD52';
const CARD_BORDER: string = '#EEEEEE';
const CHIP_BG: string = '#F5F5F5';

@Entry
@Component
struct MatchaRitual {
  // Canvas must be created before build() and drawn in onReady
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private readonly bowlSize: number = 160;

  // Compose did this in a SideEffect inside setContent; in ArkUI it belongs in aboutToAppear.
  aboutToAppear(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);          // edge-to-edge
        win.setWindowSystemBarEnable([]);             // immersive: hide status + nav bars
      })
      .catch((err: BusinessError) => {
        console.error(`Failed to enter immersive mode: ${err.code} - ${err.message}`);
      });
  }

  /**
   * Imperative replacement for Canvas { drawPath / drawOval / drawLine }.
   * Coordinate space is vp, so w/h map 1:1 to the 160vp component box.
   */
  private drawBowl(): void {
    const ctx: CanvasRenderingContext2D = this.ctx;
    const w: number = this.bowlSize;
    const h: number = this.bowlSize;
    ctx.clearRect(0, 0, w, h);

    // 1. Bowl: trapezoid with a rounded bottom (two quadratic curves)
    ctx.beginPath();
    ctx.moveTo(w * 0.15, h * 0.40);                            // top left
    ctx.lineTo(w * 0.85, h * 0.40);                            // top right
    ctx.quadraticCurveTo(w * 0.90, h * 0.90, w * 0.50, h * 0.90);
    ctx.quadraticCurveTo(w * 0.10, h * 0.90, w * 0.15, h * 0.40);
    ctx.closePath();
    ctx.fillStyle = BOWL_DARK;
    ctx.fill();

    // 2. Liquid surface: ellipse (drawOval topLeft 0.2/0.42, size 0.6 x 0.15)
    ctx.beginPath();
    ctx.ellipse(w * 0.50, h * 0.495, w * 0.30, h * 0.075, 0, 0, Math.PI * 2);
    ctx.fillStyle = MATCHA_BRIGHT;
    ctx.fill();

    // 3. Steam: three rounded-cap segments, LightGray @ 50% alpha
    ctx.strokeStyle = 'rgba(211,211,211,0.5)';
    ctx.lineWidth = 4;
    ctx.lineCap = 'round';
    const steam: number[][] = [
      [0.40, 0.30, 0.40, 0.15],
      [0.50, 0.25, 0.50, 0.10],
      [0.60, 0.30, 0.60, 0.15]
    ];
    for (let i = 0; i < steam.length; i++) {
      const s: number[] = steam[i];
      ctx.beginPath();
      ctx.moveTo(w * s[0], h * s[1]);
      ctx.lineTo(w * s[2], h * s[3]);
      ctx.stroke();
    }
  }

  // Replaces @Composable fun InfoItem
  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#C4C4C4')
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  // Replaces @Composable fun StepCard
  @Builder
  StepCard(number: string, text: string) {
    Row() {
      Stack() {
        Text(number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(32)
      .height(32)
      .borderRadius(16)          // CircleShape == half of 32
      .backgroundColor(CHIP_BG)

      Text(text)
        .fontSize(14)
        .fontColor('#3C3C3C')
        .layoutWeight(1)
        .maxLines(2)
        .margin({ left: 16 })
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: CARD_BORDER, radius: 12 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      // ---------- Top: title block ----------
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(4)
          .fontColor('#A9A9A9')
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)   // Compose FontWeight.Light
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 48 })

      // ---------- Middle: art + stats ----------
      Column() {
        Canvas(this.ctx)
          .width(this.bowlSize)
          .height(this.bowlSize)
          .onReady(() => {
            this.drawBowl();
          })

        Row() {
          this.InfoItem('TEMP', '80°C')
          this.InfoItem('WATER', '70ml')
          this.InfoItem('BAMBOO', 'Whisk')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 40 })
      }
      .alignItems(HorizontalAlign.Center)

      // ---------- Bottom: steps + action ----------
      Column() {
        Column() {
          this.StepCard('01', 'Sift 2g of matcha powder.')
        }
        .width('100%')

        Column() {
          this.StepCard('02', "Add hot water. Whisk in 'M' shape.")
        }
        .width('100%')
        .margin({ top: 12 })

        Button({ type: ButtonType.Capsule, stateEffect: true }) {
          Row() {
            // Stand-in for Icons.Default.PlayArrow — drawn, no assets needed
            Polygon({ width: 14, height: 16 })
              .points([[0, 0], [0, 16], [14, 8]])
              .fill(Color.White)
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(600)
              .fontColor(Color.White)
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor(MATCHA_GREEN)
        .margin({ top: 32 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)               // strict pure-white surface
    .justifyContent(FlexAlign.SpaceBetween)     // Arrangement.SpaceBetween
  }
}