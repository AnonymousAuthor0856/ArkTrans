import { display } from '@kit.ArkUI';

// ── Token definitions ──────────────────────────────────────────────────────────
namespace AppTokens {
  export namespace Colors {
    export const primary = '#FFD95F02';
    export const secondary = '#FF1B9AAA';
    export const tertiary = '#FFFEC601';
    export const background = '#FFF9F4EB';
    export const surface = '#FFFFFFFF';
    export const surfaceVariant = '#FFF0E3D1';
    export const outline = '#FFE1CDB2';
    export const success = '#FF56C271';
    export const warning = '#FFF4A259';
    export const error = '#FFD7263D';
    export const onPrimary = '#FF1B1B1B';
    export const onSecondary = '#FF041012';
    export const onTertiary = '#FF1E1200';
    export const onBackground = '#FF2C2A29';
    export const onSurface = '#FF2E2924';
  }

  export namespace Spacing {
    export const xs = 4;
    export const sm = 8;
    export const md = 12;
    export const lg = 16;
    export const xl = 20;
    export const xxl = 28;
    export const xxxl = 40;
  }
}

// ── Data types ─────────────────────────────────────────────────────────────────
interface Zone {
  name: string;
  humidity: number;
  temp: string;
}

// ── StatusRow component ────────────────────────────────────────────────────────
@Component
struct StatusRow {
  label: string = '';
  value: number = 0;
  accent: string = AppTokens.Colors.secondary;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Row() {
        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
        Text(`${Math.floor(this.value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(this.accent)
        .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// ── ZoneRow component ──────────────────────────────────────────────────────────
@Component
struct ZoneRow {
  zone: Zone = { name: '', humidity: 0, temp: '' };

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Row() {
        Text(this.zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(AppTokens.Colors.secondary)
        .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.sm)
    .backgroundColor('#80F0E3D1')
    .borderRadius(12)
  }
}

// ── RootScreen ─────────────────────────────────────────────────────────────────
@Entry
@Component
struct RootScreen {
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  private zones: Zone[] = [
    { name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { name: 'Hab Deck', humidity: 0.30, temp: '70°F' },
  ];

  build() {
    Column() {
      // ── Top App Bar ──────────────────────────────────────────────────────────
      Row() {
        Button('Dock', { type: ButtonType.Normal })
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(Color.Transparent)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })

        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Alerts', { type: ButtonType.Normal })
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
          .backgroundColor(Color.Transparent)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // ── Scrollable body ──────────────────────────────────────────────────────
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {

          // Mode chips
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.modes, (mode: string) => {
              Button(mode, { type: ButtonType.Normal })
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(
                  this.activeMode === mode
                    ? '#26D95F02'
                    : AppTokens.Colors.surface
                )
                .borderRadius(12)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  top: AppTokens.Spacing.xs,
                  bottom: AppTokens.Spacing.xs
                })
                .onClick(() => {
                  this.activeMode = mode;
                })
            })
          }
          .width('100%')

          // Solar wash card
          Column({ space: AppTokens.Spacing.sm }) {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)

            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontWeight(FontWeight.Normal)
              .fontColor('#B32E2924')

            Slider({
              value: this.solarLevel * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .trackColor(AppTokens.Colors.surfaceVariant)
              .selectedColor(AppTokens.Colors.primary)
              .onChange((value: number) => {
                this.solarLevel = value / 100;
              })

            Row() {
              Text('0%')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
              Text(`${Math.floor(this.solarLevel * 100)}%`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)

            Slider({
              value: this.ambientGlow * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .trackColor(AppTokens.Colors.surfaceVariant)
              .selectedColor(AppTokens.Colors.secondary)
              .onChange((value: number) => {
                this.ambientGlow = value / 100;
              })

            Progress({
              value: this.ambientGlow * 100,
              total: 100,
              type: ProgressType.Linear
            })
              .width('100%')
              .height(4)
              .color(AppTokens.Colors.secondary)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(20)

          // Orbit health card
          Column({ space: AppTokens.Spacing.sm }) {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)

            StatusRow({
              label: 'Atmos mix',
              value: 0.74,
              accent: AppTokens.Colors.secondary
            })
            StatusRow({
              label: 'Hull temp',
              value: 0.42,
              accent: AppTokens.Colors.primary
            })
            StatusRow({
              label: 'Shield sync',
              value: 0.88,
              accent: AppTokens.Colors.tertiary
            })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(20)

          // Deck zones card
          Column({ space: AppTokens.Spacing.sm }) {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)

            ForEach(this.zones, (zone: Zone) => {
              ZoneRow({ zone: zone })
            })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(20)

        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      // ── Bottom bar ───────────────────────────────────────────────────────────
      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text('Grid draw')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text('18.4 kWh')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Engage eco hold', { type: ButtonType.Normal })
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(16)
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm
          })
      }
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 8, color: '#29000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}