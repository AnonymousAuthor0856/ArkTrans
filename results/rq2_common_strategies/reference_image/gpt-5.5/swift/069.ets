class CargoCard {
  title: string;
  itemId: string;
  fill: string;

  constructor(title: string, itemId: string, fill: string) {
    this.title = title;
    this.itemId = itemId;
    this.fill = fill;
  }
}

class HubFilter {
  label: string;

  constructor(label: string) {
    this.label = label;
  }
}

class AppColors {
  static readonly primary: string = '#8B6B4C';
  static readonly secondary: string = '#C27D38';
  static readonly tertiary: string = '#F2C57C';
  static readonly tertiaryDim: string = '#7D6440';
  static readonly background: string = '#100C08';
  static readonly surface: string = '#19110D';
  static readonly surfaceTop: string = '#18110D';
  static readonly surfaceVariant: string = '#2A1C14';
  static readonly surfaceVariantDim: string = '#251912';
  static readonly outline: string = '#4F3A2C';
  static readonly success: string = '#6ECE89';
  static readonly warning: string = '#E19F41';
  static readonly error: string = '#D96666';
  static readonly onPrimary: string = '#100C08';
  static readonly onSecondary: string = '#100C08';
  static readonly onTertiary: string = '#120E04';
  static readonly onBackground: string = '#F7EAD8';
  static readonly onSurface: string = '#FBEFE0';
  static readonly onSurfaceMuted: string = '#B5A99C';
}

class AppSpacing {
  static readonly xxs: number = 6;
  static readonly xs: number = 10;
  static readonly sm: number = 14;
  static readonly md: number = 18;
  static readonly lg: number = 26;
  static readonly xl: number = 36;
  static readonly xxl: number = 48;
  static readonly xxxl: number = 62;
}

class AppRadius {
  static readonly small: number = 10;
  static readonly medium: number = 18;
  static readonly large: number = 26;
}

@Component
struct TopAppBar {
  build() {
    Stack() {
      Row() {
        Column() {
        }
        .width(26)
        .height(26)
        .borderRadius(13)
        .backgroundColor(AppColors.surfaceVariant)

        Blank()
          .layoutWeight(1)

        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurfaceMuted)
        }
        .alignItems(HorizontalAlign.Center)

        Blank()
          .layoutWeight(1)

        Column() {
        }
        .width(26)
        .height(26)
        .borderRadius(13)
        .backgroundColor(AppColors.surfaceVariant)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(64)
    .backgroundColor(AppColors.surfaceTop)
  }
}

@Component
struct FilterButtons {
  @Link activeFilter: string;
  filters: HubFilter[] = [];

  build() {
    Scroll() {
      Row({ space: AppSpacing.xs }) {
        ForEach(this.filters, (filter: HubFilter) => {
          Text(filter.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.activeFilter === filter.label ? AppColors.onSecondary : AppColors.onSurface)
            .padding({
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              top: AppSpacing.xxs,
              bottom: AppSpacing.xxs
            })
            .backgroundColor(this.activeFilter === filter.label ? AppColors.secondary : AppColors.surfaceVariant)
            .borderRadius(AppRadius.small)
            .onClick(() => {
              this.activeFilter = filter.label;
            })
        }, (filter: HubFilter) => filter.label)
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct CargoCardView {
  card: CargoCard = new CargoCard('', '', '');

  build() {
    Column({ space: AppSpacing.sm }) {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
        }
        .width('100%')
        .height(90)
        .borderRadius(AppRadius.small)
        .backgroundColor(AppColors.surface)

        Column() {
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor(AppColors.tertiaryDim)
      }
      .width('100%')
      .height(90)

      Column({ space: AppSpacing.xxs }) {
        Text(this.card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.card.itemId)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurfaceMuted)
          .maxLines(1)

        Text('Fill ' + this.card.fill)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.success)
          .maxLines(1)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppRadius.medium)
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct Index {
  @State activeFilter: string = 'All';

  cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%')
  ];

  filters: HubFilter[] = [
    new HubFilter('All'),
    new HubFilter('Atlantic'),
    new HubFilter('Pacific'),
    new HubFilter('Inland')
  ];

  getCardRows(): CargoCard[][] {
    let rows: CargoCard[][] = [];
    for (let index = 0; index < this.cards.length; index += 2) {
      let row: CargoCard[] = [this.cards[index]];
      if (index + 1 < this.cards.length) {
        row.push(this.cards[index + 1]);
      }
      rows.push(row);
    }
    return rows;
  }

  build() {
    Stack() {
      Column() {
        TopAppBar()

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            FilterButtons({ activeFilter: $activeFilter, filters: this.filters })

            Text('Cargo grid')
              .width('100%')
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)

            Column({ space: AppSpacing.sm }) {
              ForEach(this.getCardRows(), (row: CargoCard[]) => {
                Row({ space: AppSpacing.sm }) {
                  ForEach(row, (card: CargoCard) => {
                    CargoCardView({ card: card })
                      .layoutWeight(1)
                  }, (card: CargoCard) => card.itemId)

                  if (row.length === 1) {
                    Blank()
                      .layoutWeight(1)
                  }
                }
                .width('100%')
                .alignItems(VerticalAlign.Top)
              }, (row: CargoCard[]) => row[0].itemId)
            }
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            Row() {
              Column({ space: AppSpacing.xs }) {
                Text('Manifest filter')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurfaceMuted)

                Text(this.activeFilter)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .padding({
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                top: AppSpacing.md,
                bottom: AppSpacing.md
              })
              .backgroundColor(AppColors.surfaceVariantDim)
              .borderRadius(AppRadius.medium)
            }
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          }
          .width('100%')
          .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}