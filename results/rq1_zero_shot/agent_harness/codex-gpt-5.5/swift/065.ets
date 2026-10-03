class AppColors {
  static primary: string = '#111111';
  static secondary: string = '#2A2A2A';
  static tertiary: string = '#474747';
  static background: string = '#F6F6F6';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#EDEDED';
  static outline: string = '#D1D1D1';
  static success: string = '#2E7D32';
  static warning: string = '#B98900';
  static error: string = '#B3261E';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#0A0A0A';
  static onBackground: string = '#0A0A0A';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
  static xxxl: number = 48;
}

class AssetMarker {
  id: number;
  name: string;
  type: string;
  x: string;
  y: string;

  constructor(id: number, name: string, type: string, x: string, y: string) {
    this.id = id;
    this.name = name;
    this.type = type;
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct RootScreen {
  @State private enabledCats: string[] = ['Warehouse', 'Device', 'Office'];
  @State private assetName: string = '';
  @State private assetCode: string = '';
  @State private assetType: string = 'Device';
  @State private selectedId: number = -1;
  private categories: string[] = ['Warehouse', 'Device', 'Office'];
  private markers: AssetMarker[] = [
    new AssetMarker(1, 'Main Warehouse', 'Warehouse', '18%', '34%'),
    new AssetMarker(2, 'CNC-07', 'Device', '52%', '46%'),
    new AssetMarker(3, 'HQ Office', 'Office', '75%', '62%'),
    new AssetMarker(4, 'Spare Parts', 'Warehouse', '33%', '78%')
  ];

  private isEnabled(category: string): boolean {
    return this.enabledCats.indexOf(category) >= 0;
  }

  private markerColor(type: string): string {
    if (type === 'Warehouse') {
      return AppColors.tertiary;
    }
    if (type === 'Device') {
      return AppColors.secondary;
    }
    return AppColors.primary;
  }

  private selectedName(): string {
    let name: string = 'None';
    this.markers.forEach((marker: AssetMarker) => {
      if (marker.id === this.selectedId) {
        name = marker.name;
      }
    });
    return name;
  }

  @Builder
  private CategoryChip(category: string) {
    Text(category)
      .fontSize(this.isEnabled(category) ? 16 : 14)
      .fontWeight(this.isEnabled(category) ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.isEnabled(category) ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.isEnabled(category) ? AppColors.primary : AppColors.surface)
      .borderRadius(8)
      .border({ width: 1, color: AppColors.outline })
      .onClick(() => {
        if (this.isEnabled(category)) {
          this.enabledCats = this.enabledCats.filter((item: string) => item !== category);
        } else {
          this.enabledCats = this.enabledCats.concat([category]);
        }
      })
  }

  @Builder
  private TextFieldBox(placeholder: string, value: string, tag: string) {
    TextInput({ placeholder: placeholder, text: value })
      .height(42)
      .fontSize(14)
      .fontColor(AppColors.onSurface)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(8)
      .border({ width: 1, color: AppColors.outline })
      .onChange((text: string) => {
        if (tag === 'name') {
          this.assetName = text;
        } else if (tag === 'code') {
          this.assetCode = text;
        } else {
          this.assetType = text;
        }
      })
  }

  @Builder
  private SelectedCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Selected')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Text(this.selectedName())
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })
  }

  @Builder
  private MapGridOverlay() {
    Stack() {
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (_i: number) => {
          Divider().height(1).color(AppColors.surfaceVariant)
          Blank()
        })
        Divider().height(1).color(AppColors.surfaceVariant)
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .height('100%')

      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (_i: number) => {
          Divider().vertical(true).width(1).color(AppColors.surfaceVariant)
          Blank()
        })
        Divider().vertical(true).width(1).color(AppColors.surfaceVariant)
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .height('100%')
    }
  }

  @Builder
  private MapMarker(marker: AssetMarker) {
    if (this.isEnabled(marker.type)) {
      Stack({ alignContent: Alignment.TopStart }) {
        Circle()
          .width(this.selectedId === marker.id ? 28 : 22)
          .height(this.selectedId === marker.id ? 28 : 22)
          .fill(this.markerColor(marker.type))
          .stroke(this.selectedId === marker.id ? AppColors.primary : AppColors.surface)
          .strokeWidth(2)
        Text(marker.type)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surface)
          .borderRadius(8)
          .border({ width: 1, color: AppColors.outline })
          .position({ x: 56, y: 8 })
      }
      .width(120)
      .height(42)
      .position({ x: marker.x, y: marker.y })
      .onClick(() => {
        this.selectedId = this.selectedId === marker.id ? -1 : marker.id;
      })
    }
  }

  @Builder
  private MapArea() {
    Stack() {
      this.MapGridOverlay()
      ForEach(this.markers, (marker: AssetMarker) => {
        this.MapMarker(marker)
      })
    }
    .width('100%')
    .height(360)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  private BottomBar() {
    Row({ space: AppSpacing.md }) {
      Button('Reset')
        .height(48)
        .layoutWeight(1)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(12)
        .onClick(() => {
          this.assetName = '';
          this.assetCode = '';
          this.assetType = 'Device';
          this.selectedId = -1;
        })
      Button('Save Asset')
        .height(48)
        .layoutWeight(1)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
    }
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .width('100%')
    .backgroundColor(AppColors.surface)
  }

  build() {
    Column({ space: 0 }) {
      Text('Asset Inventory')
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .height(86)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.surface)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Scroll() {
            Row({ space: AppSpacing.sm }) {
              ForEach(this.categories, (category: string) => {
                this.CategoryChip(category)
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md })
          .width('100%')

          Row({ space: AppSpacing.lg }) {
            Column({ space: AppSpacing.md }) {
              this.TextFieldBox('Asset Name', this.assetName, 'name')
              this.TextFieldBox('Asset Code', this.assetCode, 'code')
              this.TextFieldBox('Asset Type', this.assetType, 'type')
              this.SelectedCard()
            }
            .layoutWeight(1)

            this.MapArea()
              .layoutWeight(1)
          }
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          .width('100%')
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .padding({ bottom: AppSpacing.md })

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
