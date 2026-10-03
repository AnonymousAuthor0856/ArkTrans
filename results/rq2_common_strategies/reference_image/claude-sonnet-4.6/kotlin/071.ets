/* ─────────────────────────────────────────────────────────────
   entry/src/main/ets/pages/Index.ets
   Single-file ArkTS port of the "QuizForge / Citrus Pop" Compose screen.
   ───────────────────────────────────────────────────────────── */

const NAME: string = '163*QuizForge*en';
const UI_TYPE: string = 'Quiz';
const STYLE_THEME: string = 'Citrus Pop';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';
const COLOR_PALETTE: string =
  'primary:#FF8A2A secondary:#FFC857 tertiary:#68D672 background:#FFF9F2 surface:#FFFFFF ' +
  'surfaceVariant:#FFE4CC outline:#E2B088 success:#2AC28B warning:#FFB347 error:#F45B69 ' +
  'onPrimary:#2C0D00 onSecondary:#301A00 onTertiary:#083919 onBackground:#1E1205 onSurface:#311F10';
const DENSITY_SPACING: string = 'Compact';
const COMPLEXITY: string = 'QuestionCard,OptionChip,Progress';
const EXTRA: string = 'Citrus quiz forge with cards, chips, and timed progress';

/** Design tokens — colour roles (AARRGGBB where alpha is folded in). */
class Tint {
  static readonly primary: string = '#FF8A2A';
  static readonly secondary: string = '#FFC857';
  static readonly tertiary: string = '#68D672';
  static readonly background: string = '#FFF9F2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFE4CC';
  static readonly outline: string = '#E2B088';
  static readonly success: string = '#2AC28B';
  static readonly warning: string = '#FFB347';
  static readonly error: string = '#F45B69';
  static readonly onPrimary: string = '#2C0D00';
  static readonly onSecondary: string = '#301A00';
  static readonly onTertiary: string = '#083919';
  static readonly onBackground: string = '#1E1205';
  static readonly onSurface: string = '#311F10';

  // alpha composites used by the Compose source
  static readonly primaryA20: string = '#33FF8A2A';   // primary.copy(alpha = 0.20f)
  static readonly primaryA35: string = '#59FF8A2A';   // primary.copy(alpha = 0.35f)
  static readonly secondaryA20: string = '#33FFC857'; // secondary.copy(alpha = 0.20f)
  static readonly onSurfaceA70: string = '#B3311F10'; // onSurface.copy(alpha = 0.70f)
  static readonly shadowSoft: string = '#1F000000';
  static readonly shadowCard: string = '#26000000';
}

/** Type scale — size / weight / lineHeight. */
class Type {
  static readonly displaySize: number = 30;
  static readonly displayLine: number = 34;
  static readonly headlineSize: number = 22;
  static readonly headlineLine: number = 28;
  static readonly titleSize: number = 16;
  static readonly titleLine: number = 22;
  static readonly bodySize: number = 14;
  static readonly bodyLine: number = 20;
  static readonly labelSize: number = 12;
  static readonly labelLine: number = 16;
}

/** Corner radii. */
class Radius {
  static readonly small: number = 10;
  static readonly medium: number = 18;
  static readonly large: number = 28;
}

/** Spacing scale. */
class Gap {
  static readonly xxs: number = 4;
  static readonly xs: number = 8;
  static readonly sm: number = 12;
  static readonly md: number = 16;
  static readonly lg: number = 20;
  static readonly xl: number = 28;
  static readonly xxl: number = 36;
  static readonly xxxl: number = 46;
}

/** Elevation mapping (blur radius, y-offset, opacity). */
class Elevation {
  radius: number;
  offsetY: number;
  opacity: number;

  constructor(radius: number, offsetY: number, opacity: number) {
    this.radius = radius;
    this.offsetY = offsetY;
    this.opacity = opacity;
  }

  static readonly level1: Elevation = new Elevation(4, 2, 0.18);
  static readonly level2: Elevation = new Elevation(8, 4, 0.22);
  static readonly level3: Elevation = new Elevation(12, 6, 0.26);
  static readonly level4: Elevation = new Elevation(18, 8, 0.30);
  static readonly level5: Elevation = new Elevation(26, 12, 0.34);
}

/** Model. */
class QuizQuestion {
  category: string;
  prompt: string;
  options: string[];
  hint: string;

  constructor(category: string, prompt: string, options: string[], hint: string) {
    this.category = category;
    this.prompt = prompt;
    this.options = options;
    this.hint = hint;
  }
}

class StreakCard {
  label: string;
  value: string;

  constructor(label: string, value: string) {
    this.label = label;
    this.value = value;
  }
}

@Entry
@Component
struct Index {
  @State selectedIndex: number = -1;
  private progressPercent: number = 45;

  private question: QuizQuestion = new QuizQuestion(
    'Citrus crafts',
    'Which zest carrier gives the brightest aroma when infused cold?',
    ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip'],
    'Think surface area'
  );

  private streaks: StreakCard[] = [
    new StreakCard('Current streak', '5 days'),
    new StreakCard('Accuracy', '84%'),
    new StreakCard('Rank', 'Top 12%')
  ];

  build() {
    Column() {
      this.TopBar();

      Scroll() {
        Column({ space: Gap.md }) {
          this.QuestionCard();
          this.TrackersCard();
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({
          left: Gap.lg,
          right: Gap.lg,
          top: Gap.sm,
          bottom: Gap.xl
        });
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Tint.background);
  }

  /** CenterAlignedTopAppBar equivalent: two avatar slots + centred title block. */
  @Builder
  TopBar() {
    Stack() {
      Row() {
        Column()
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor(Tint.surfaceVariant);

        Column()
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor(Tint.primaryA35);
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: Gap.xs, right: Gap.xs });

      Column({ space: 2 }) {
        Text('QuizForge')
          .fontSize(Type.titleSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(Type.titleLine)
          .fontColor(Tint.onSurface);

        Text('Aroma sprint')
          .fontSize(Type.labelSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(Type.labelLine)
          .fontColor(Tint.onSurfaceA70);
      }
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height(64);
  }

  /** Elevated question surface: header row, progress rail, prompt, chips, hint. */
  @Builder
  QuestionCard() {
    Column({ space: Gap.sm }) {
      Row() {
        Text(this.question.category)
          .fontSize(Type.titleSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(Type.titleLine)
          .fontColor(Tint.onSurface)
          .layoutWeight(1);

        Text(`${this.progressPercent}%`)
          .fontSize(Type.bodySize)
          .fontWeight(FontWeight.Normal)
          .lineHeight(Type.bodyLine)
          .fontColor(Tint.secondary);
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      Progress({
        value: this.progressPercent,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(6)
        .color(Tint.primary)
        .backgroundColor(Tint.surfaceVariant);

      Text(this.question.prompt)
        .fontSize(Type.headlineSize)
        .fontWeight(FontWeight.Bold)
        .lineHeight(Type.headlineLine)
        .fontColor(Tint.onSurface)
        .width('100%');

      Column({ space: Gap.xs }) {
        ForEach(this.question.options, (option: string, index: number) => {
          this.OptionChip(option, index);
        }, (option: string) => option);
      }
      .width('100%');

      Text(`Hint: ${this.question.hint}`)
        .fontSize(Type.labelSize)
        .fontWeight(FontWeight.Medium)
        .lineHeight(Type.labelLine)
        .fontColor(Tint.onSurface)
        .padding({
          left: Gap.sm,
          right: Gap.sm,
          top: Gap.xs,
          bottom: Gap.xs
        })
        .backgroundColor(Tint.secondaryA20)
        .borderRadius(Radius.small);
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(Gap.md)
    .backgroundColor(Tint.surface)
    .borderRadius(Radius.large)
    .shadow({
      radius: Elevation.level2.radius,
      color: Tint.shadowCard,
      offsetX: 0,
      offsetY: Elevation.level2.offsetY
    });
  }

  /** Selectable answer row — outline + tint swap on selection. */
  @Builder
  OptionChip(option: string, index: number) {
    Text(option)
      .fontSize(Type.titleSize)
      .fontWeight(FontWeight.Medium)
      .lineHeight(Type.titleLine)
      .fontColor(Tint.onSurface)
      .width('100%')
      .padding(Gap.sm)
      .backgroundColor(this.selectedIndex === index ? Tint.primaryA20 : Tint.surfaceVariant)
      .borderRadius(Radius.medium)
      .border({
        width: 1,
        color: this.selectedIndex === index ? Tint.primary : Tint.outline
      })
      .onClick(() => {
        this.selectedIndex = index;
      });
  }

  /** Tracker strip + primary call to action. */
  @Builder
  TrackersCard() {
    Column({ space: Gap.xs }) {
      Text('Trackers')
        .fontSize(Type.headlineSize)
        .fontWeight(FontWeight.Bold)
        .lineHeight(Type.headlineLine)
        .fontColor(Tint.onSurface)
        .width('100%');

      Row({ space: Gap.sm }) {
        ForEach(this.streaks, (streak: StreakCard) => {
          Column({ space: Gap.xxs }) {
            Text(streak.label)
              .fontSize(Type.labelSize)
              .fontWeight(FontWeight.Medium)
              .lineHeight(Type.labelLine)
              .fontColor(Tint.onSurfaceA70)
              .textAlign(TextAlign.Center);

            Text(streak.value)
              .fontSize(Type.titleSize)
              .fontWeight(FontWeight.Medium)
              .lineHeight(Type.titleLine)
              .fontColor(Tint.onSurface)
              .textAlign(TextAlign.Center);
          }
          .layoutWeight(1)
          .padding(Gap.sm)
          .backgroundColor(Tint.surfaceVariant)
          .borderRadius(Radius.medium)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center);
        }, (streak: StreakCard) => streak.label);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);

      Button('Submit answer')
        .fontSize(Type.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(Tint.onPrimary)
        .width('100%')
        .height(48)
        .backgroundColor(Tint.primary)
        .borderRadius(Radius.medium)
        .onClick(() => {
        });
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(Gap.md)
    .backgroundColor(Tint.surface)
    .borderRadius(Radius.large)
    .shadow({
      radius: Elevation.level1.radius,
      color: Tint.shadowSoft,
      offsetX: 0,
      offsetY: Elevation.level1.offsetY
    });
  }
}