/**
 * Coupon Pack — ArkTS / ArkUI port of the Kotlin Compose screen.
 *
 * Target file : entry/src/main/ets/pages/Index.ets
 * Route       : entry/src/main/resources/base/profile/main_pages.json
 *               { "src": ["pages/Index"] }
 * Preview     : DevEco Studio Previewer (or P50 emulator, 1080x2340, light mode).
 *               The build() below reproduces the reference screenshot 1:1 —
 *               centred "Coupon Pack" bar with a dark + a purple dot, full-screen
 *               cyan→lilac gradient, white map card with canvas pins and the A/B/C
 *               legend chip, horizontally scrolling coupon cards, two pill buttons.
 *
 * Notes on the port:
 *  - Compose dp/sp → ArkUI vp/fp-free numbers (ArkUI numbers are vp by default; the
 *    lpx / fp conversion is handled by the framework).
 *  - Canvas DrawScope worked in device px, so the original pin offsets (140,220),
 *    (320,400), (520,300) are converted to vp for the 720x1280 @1.85 baseline:
 *    (76,119), (173,216), (281,162) with radius 8 — pin B therefore stays clipped
 *    at the bottom edge exactly as in the screenshot.
 *  - Compose Color.copy(alpha = x) → rgba(...) via withAlpha().
 */

class AppTokens {
  // ---- Colors ----
  static readonly primary: string = '#7B61FF';
  static readonly secondary: string = '#26C6DA';
  static readonly tertiary: string = '#FF8A80';
  static readonly background: string = '#F5F7FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F0F2F8';
  static readonly outline: string = '#E0E3EB';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0B1220';
  static readonly onTertiary: string = '#0B1220';
  static readonly onBackground: string = '#0B1220';
  static readonly onSurface: string = '#0B1220';

  // ---- Typography ----
  static readonly fsDisplay: number = 28;
  static readonly fsHeadline: number = 20;
  static readonly fsTitle: number = 16;
  static readonly fsBody: number = 14;
  static readonly fsLabel: number = 12;

  static readonly fwNormal: number = 400;
  static readonly fwMedium: number = 500;
  static readonly fwSemiBold: number = 600;
  static readonly fwBold: number = 700;

  // ---- Shapes ----
  static readonly radiusSmall: number = 8;
  static readonly radiusMedium: number = 14;
  static readonly radiusLarge: number = 20;

  // ---- Spacing ----
  static readonly spaceXs: number = 4;
  static readonly spaceSm: number = 8;
  static readonly spaceMd: number = 12;
  static readonly spaceLg: number = 16;
  static readonly spaceXl: number = 24;
  static readonly spaceXxl: number = 32;

  // ---- ElevationMapping.level2 (elevation / radius / dy / opacity) ----
  static readonly elev2Blur: number = 10;
  static readonly elev2Dy: number = 6;
  static readonly elev2Opacity: number = 0.16;

  static readonly elev1Blur: number = 8;
  static readonly elev1Dy: number = 4;
  static readonly elev1Opacity: number = 0.12;
}

/** Compose `Color.copy(alpha = a)` for a #RRGGBB literal. */
function withAlpha(hex: string, alpha: number): string {
  const r: number = parseInt(hex.substring(1, 3), 16);
  const g: number = parseInt(hex.substring(3, 5), 16);
  const b: number = parseInt(hex.substring(5, 7), 16);
  const a: string = alpha.toFixed(2);
  return 'rgba(' + r + ', ' + g + ', ' + b + ', ' + a + ')';
}

class Coupon {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;

  constructor(id: number, title: string, value: string, colorA: string, colorB: string) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.colorA = colorA;
    this.colorB = colorB;
  }
}

class MapPin {
  x: number;
  y: number;
  label: string;
  tint: string;

  constructor(x: number, y: number, label: string, tint: string) {
    this.x = x;
    this.y = y;
    this.label = label;
    this.tint = tint;
  }
}

@Entry
@Component
struct Index {
  @State coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', AppTokens.primary, AppTokens.secondary),
    new Coupon(2, 'Cafe Bundle', '-15%', AppTokens.secondary, AppTokens.tertiary),
    new Coupon(3, 'Electro Deal', '-$20', AppTokens.tertiary, AppTokens.primary),
    new Coupon(4, 'Fashion Duo', '-10%', AppTokens.secondary, AppTokens.primary)
  ];

  private pins: MapPin[] = [
    new MapPin(76, 119, 'A', AppTokens.primary),
    new MapPin(173, 216, 'B', AppTokens.secondary),
    new MapPin(281, 162, 'C', AppTokens.tertiary)
  ];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private drawMap(): void {
    const ctx: CanvasRenderingContext2D = this.canvasCtx;
    const w: number = ctx.width;
    const h: number = ctx.height;

    ctx.fillStyle = AppTokens.surfaceVariant;
    ctx.fillRect(0, 0, w, h);

    this.pins.forEach((p: MapPin) => {
      ctx.beginPath();
      ctx.fillStyle = p.tint;
      ctx.arc(p.x, p.y, 8, 0, Math.PI * 2);
      ctx.fill();
      ctx.closePath();
    });
  }

  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Coupon Pack')
        .fontSize(AppTokens.fsDisplay)
        .fontWeight(AppTokens.fwBold)
        .fontColor(AppTokens.onSurface)

      Row() {
        Circle().width(20).height(20).fill(AppTokens.onSurface)
        Circle().width(20).height(20).fill(AppTokens.primary)
      }
      .width('100%')
      .height(64)
      .padding({ left: AppTokens.spaceLg, right: AppTokens.spaceLg })
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height(64)
  }

  @Builder
  MapCard() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Canvas(this.canvasCtx)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawMap();
        })

      Row({ space: AppTokens.spaceSm }) {
        Circle().width(10).height(10).fill(AppTokens.primary)
        Text('A').fontSize(AppTokens.fsLabel).fontWeight(AppTokens.fwMedium).fontColor(AppTokens.onSurface)
        Circle().width(10).height(10).fill(AppTokens.secondary)
        Text('B').fontSize(AppTokens.fsLabel).fontWeight(AppTokens.fwMedium).fontColor(AppTokens.onSurface)
        Circle().width(10).height(10).fill(AppTokens.tertiary)
        Text('C').fontSize(AppTokens.fsLabel).fontWeight(AppTokens.fwMedium).fontColor(AppTokens.onSurface)
      }
      .padding({
        left: AppTokens.spaceMd,
        right: AppTokens.spaceMd,
        top: AppTokens.spaceXs,
        bottom: AppTokens.spaceXs
      })
      .backgroundColor(withAlpha(AppTokens.surface, 0.9))
      .borderRadius(AppTokens.radiusSmall)
    }
    .width('100%')
    .aspectRatio(16 / 9)
    .padding(AppTokens.spaceMd)
    .backgroundColor(AppTokens.surface)
    .borderRadius(AppTokens.radiusLarge)
    .shadow({
      radius: AppTokens.elev1Blur,
      color: withAlpha(AppTokens.onSurface, AppTokens.elev1Opacity),
      offsetX: 0,
      offsetY: AppTokens.elev1Dy
    })
  }

  @Builder
  CouponCard(c: Coupon) {
    Column() {
      Row({ space: AppTokens.spaceSm }) {
        Circle().width(14).height(14).fill(AppTokens.primary)
        Text(c.title)
          .fontSize(AppTokens.fsTitle)
          .fontWeight(AppTokens.fwMedium)
          .fontColor(AppTokens.onSurface)
      }
      .width('100%')

      Text(c.value)
        .fontSize(AppTokens.fsDisplay)
        .fontWeight(AppTokens.fwBold)
        .fontColor(AppTokens.onSurface)

      Button('Redeem', { type: ButtonType.Normal, stateEffect: true })
        .width('100%')
        .height(40)
        .borderRadius(AppTokens.radiusMedium)
        .backgroundColor(AppTokens.primary)
        .fontColor(AppTokens.onPrimary)
        .fontSize(AppTokens.fsLabel)
        .fontWeight(AppTokens.fwMedium)
    }
    .width(200)
    .height(140)
    .padding(AppTokens.spaceLg)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius(AppTokens.radiusLarge)
    .backgroundColor(AppTokens.surface)
    .linearGradient({
      direction: GradientDirection.Right,
      colors: [
        [withAlpha(c.colorA, 0.18), 0.0],
        [withAlpha(c.colorB, 0.18), 1.0]
      ]
    })
    .shadow({
      radius: AppTokens.elev2Blur,
      color: withAlpha(AppTokens.onSurface, AppTokens.elev2Opacity),
      offsetX: 0,
      offsetY: AppTokens.elev2Dy
    })
  }

  @Builder
  CouponRow() {
    List({ space: AppTokens.spaceLg }) {
      ForEach(this.coupons, (item: Coupon) => {
        ListItem() {
          this.CouponCard(item)
        }
      }, (item: Coupon) => item.id.toString())
    }
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
    .width('100%')
    .height(150)
  }

  @Builder
  BottomActions() {
    Row({ space: AppTokens.spaceMd }) {
      Button('My Coupons', { type: ButtonType.Normal, stateEffect: true })
        .layoutWeight(1)
        .height(52)
        .borderRadius(AppTokens.radiusLarge)
        .backgroundColor(AppTokens.secondary)
        .fontColor(AppTokens.onSecondary)
        .fontSize(AppTokens.fsTitle)
        .fontWeight(AppTokens.fwMedium)

      Button('Explore More', { type: ButtonType.Normal, stateEffect: true })
        .layoutWeight(1)
        .height(52)
        .borderRadius(AppTokens.radiusLarge)
        .backgroundColor(AppTokens.primary)
        .fontColor(AppTokens.onPrimary)
        .fontSize(AppTokens.fsTitle)
        .fontWeight(AppTokens.fwMedium)
    }
    .width('100%')
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Full-screen gradient: secondary 25% -> background -> primary 25%
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [withAlpha(AppTokens.secondary, 0.25), 0.0],
            [AppTokens.background, 0.5],
            [withAlpha(AppTokens.primary, 0.25), 1.0]
          ]
        })

      Column() {
        this.TopBar()

        Column({ space: AppTokens.spaceLg }) {
          Text('Nearby Packs')
            .fontSize(AppTokens.fsHeadline)
            .fontWeight(AppTokens.fwSemiBold)
            .fontColor(AppTokens.onSurface)

          this.MapCard()

          Text('Your Coupon Packs')
            .fontSize(AppTokens.fsHeadline)
            .fontWeight(AppTokens.fwSemiBold)
            .fontColor(AppTokens.onSurface)

          this.CouponRow()

          this.BottomActions()
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.spaceLg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}