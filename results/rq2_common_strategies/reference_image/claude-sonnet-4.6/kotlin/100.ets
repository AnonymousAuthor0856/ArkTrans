/* ─────────────────────────────────────────────────────────────────────────
 * pages/Index.ets   —  Habit Tracker  (ArkTS / ArkUI, API 11+)
 * Direct port of the Kotlin Compose HabitTrackerScreen.
 * ───────────────────────────────────────────────────────────────────────── */

const PRIMARY_BLACK: string = '#121212';
const BACKGROUND_WHITE: string = '#FFFFFF';
const SURFACE_GRAY: string = '#F5F5F5';
const TEXT_SECONDARY: string = '#757575';
const ACCENT_GREEN: string = '#4CAF50';
const STAR_GOLD: string = '#FFD700';
const WHITE_70: string = '#B3FFFFFF';   // Color.White.copy(alpha = 0.7f)

/* ── Stateful habit row (local toggle, mirrors remember { mutableStateOf(…) }) ── */
@Component
struct HabitItem {
  @Prop iconSymbol: Resource = $r('sys.symbol.star');
  @Prop title: string = '';
  @Prop subtitle: string = '';
  @Prop initiallyCompleted: boolean = false;
  @State checked: boolean = false;

  aboutToAppear(): void {
    this.checked = this.initiallyCompleted;
  }

  build() {
    Row() {
      // ── Leading icon in a 48dp grey circle ──
      Stack() {
        SymbolGlyph(this.iconSymbol)
          .fontSize(24)
          .fontColor([PRIMARY_BLACK])
      }
      .width(48)
      .height(48)
      .backgroundColor(SURFACE_GRAY)
      .borderRadius(24)

      // ── Title / subtitle ──
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked ? TEXT_SECONDARY : PRIMARY_BLACK)
          .decoration({
            type: this.checked ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: TEXT_SECONDARY
          })
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(TEXT_SECONDARY)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      // ── Trailing check circle ──
      Stack() {
        if (this.checked) {
          SymbolGlyph($r('sys.symbol.checkmark'))
            .fontSize(18)
            .fontColor([Color.White])
        }
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(this.checked ? ACCENT_GREEN : Color.Transparent)
      .border({ width: 2, color: this.checked ? ACCENT_GREEN : SURFACE_GRAY })
      .margin({ left: 8 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .backgroundColor(BACKGROUND_WHITE)
    .borderRadius(16)
    .border({ width: 1, color: SURFACE_GRAY })
    .margin({ bottom: 16 })
    .onClick(() => {
      this.checked = !this.checked;
    })
  }
}

/* ── Screen ── */
@Entry
@Component
struct HabitTracker {
  build() {
    Scroll() {
      Column() {
        // ─────────────── Top bar ───────────────
        Row() {
          Column() {
            Text('THURSDAY')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(TEXT_SECONDARY)
              .letterSpacing(1)
            Text('Dec 04')
              .fontSize(24)
              .fontWeight(900)
              .fontColor(PRIMARY_BLACK)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Stack() {
            SymbolGlyph($r('sys.symbol.gearshape'))
              .fontSize(20)
              .fontColor([PRIMARY_BLACK])
          }
          .width(40)
          .height(40)
          .borderRadius(20)
          .border({ width: 1, color: SURFACE_GRAY })
          .onClick(() => {
            /* no-op */
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)

        // ─────────────── Hero stats card ───────────────
        this.StatsCard()
          .margin({ top: 32 })

        // ─────────────── Section label ───────────────
        Text("TODAY'S GOALS")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_SECONDARY)
          .letterSpacing(1.5)
          .width('100%')
          .margin({ top: 32, bottom: 16 })

        // ─────────────── Habit list ───────────────
        HabitItem({
          iconSymbol: $r('sys.symbol.face_smiling'),
          title: 'Morning Meditation',
          subtitle: '15 minutes mindfulness',
          initiallyCompleted: true
        })

        HabitItem({
          iconSymbol: $r('sys.symbol.play_fill'),
          title: 'Gym Session',
          subtitle: 'Upper body workout',
          initiallyCompleted: false
        })

        HabitItem({
          iconSymbol: $r('sys.symbol.star'),
          title: 'Learn Spanish',
          subtitle: 'Daily lesson completed',
          initiallyCompleted: false
        })

        HabitItem({
          iconSymbol: $r('sys.symbol.heart'),
          title: 'Drink Water',
          subtitle: '2L target',
          initiallyCompleted: false
        })

        // ─────────────── Inspiration card ───────────────
        Column() {
          SymbolGlyph($r('sys.symbol.checkmark_circle'))
            .fontSize(20)
            .fontColor([TEXT_SECONDARY])
          Text('Small steps every day add up to big results over time.')
            .fontSize(14)
            .fontColor(PRIMARY_BLACK)
            .fontStyle(FontStyle.Italic)
            .lineHeight(20)
            .margin({ top: 12 })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(20)
        .backgroundColor(SURFACE_GRAY)
        .borderRadius(16)
        .margin({ top: 24, bottom: 48 })
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .backgroundColor(BACKGROUND_WHITE)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  /* ── Hero card (equivalent of StatsCard(), height 140dp / radius 24dp) ── */
  @Builder
  StatsCard() {
    Column() {
      Text('Overall Progress')
        .fontSize(14)
        .fontColor(WHITE_70)

      Text('85%')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .margin({ top: 8 })

      Row() {
        SymbolGlyph($r('sys.symbol.star'))
          .fontSize(16)
          .fontColor([STAR_GOLD])
        Text('12 Day Streak!')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .margin({ left: 4 })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(140)
    .padding(24)
    .backgroundColor(PRIMARY_BLACK)
    .borderRadius(24)
  }
}