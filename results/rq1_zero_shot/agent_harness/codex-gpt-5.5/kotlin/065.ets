const NAME: string = "109AssetInventoryen";
const UI_TYPE: string = "Form";
const STYLE_THEME: string = "Monochrome";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#2A2A2A';
  static readonly tertiary: string = '#474747';
  static readonly background: string = '#F6F6F6';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EDEDED';
  static readonly outline: string = '#D1D1D1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#0A0A0A';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class AssetMarker {
  id: number;
  name: string;
  type: string;
  x: number;
  y: number;

  constructor(id: number, name: string, type: string, x: number, y: number) {
    this.id = id;
    this.name = name;
    this.type = type;
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct MainActivity {
  @State warehouseOn: boolean = true;
  @State deviceOn: boolean = true;
  @State officeOn: boolean = true;
  @State assetName: string = '';
  @State assetCode: string = '';
  @State assetType: string = 'Device';
  @State selectedId: number = -1;

  private markers: AssetMarker[] = [
    new AssetMarker(1, 'Main Warehouse', 'Warehouse', 18, 34),
    new AssetMarker(2, 'CNC-07', 'Device', 52, 46),
    new AssetMarker(3, 'HQ Office', 'Office', 75, 62),
    new AssetMarker(4, 'Spare Parts', 'Warehouse', 33, 78)
  ];

  private isCategoryOn(type: string): boolean {
    if (type === 'Warehouse') {
      return this.warehouseOn;
    }
    if (type === 'Device') {
      return this.deviceOn;
    }
    return this.officeOn;
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
    const marker = this.markers.find((item: AssetMarker) => item.id === this.selectedId);
    return marker ? marker.name : 'None';
  }

  private resetForm(): void {
    this.assetName = '';
    this.assetCode = '';
    this.assetType = 'Device';
    this.selectedId = -1;
  }

  @Builder
  FilterChip(label: string, selected: boolean) {
    Text(label)
      .fontSize(selected ? 16 : 14)
      .fontWeight(selected ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(selected ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(selected ? AppColors.primary : AppColors.surface)
      .borderRadius(8)
      .border({ width: 1, color: AppColors.outline })
      .onClick(() => {
        if (label === 'Warehouse') {
          this.warehouseOn = !this.warehouseOn;
        } else if (label === 'Device') {
          this.deviceOn = !this.deviceOn;
        } else {
          this.officeOn = !this.officeOn;
        }
      })
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      ForEach([1, 2, 3, 4, 5, 6], (line: number) => {
        Blank()
          .width('100%')
          .height(1)
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: '0%', y: `${line * 13}%` })
        Blank()
          .width(1)
          .height('100%')
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: `${line * 13}%`, y: '0%' })
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
  }

  @Builder
  MapMarker(marker: AssetMarker) {
    Stack() {
      Circle()
        .width(this.selectedId === marker.id ? 28 : 22)
        .height(this.selectedId === marker.id ? 28 : 22)
        .fill(this.markerColor(marker.type))
        .stroke(this.selectedId === marker.id ? AppColors.primary : AppColors.surface)
        .strokeWidth(2)
        .position({ x: `${marker.x}%`, y: `${marker.y}%` })
        .onClick(() => {
          this.selectedId = this.selectedId === marker.id ? -1 : marker.id;
        })
      Text(marker.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
        .backgroundColor(AppColors.surface)
        .borderRadius(8)
        .border({ width: 1, color: AppColors.outline })
        .position({ x: `${Math.min(marker.x + 8, 70)}%`, y: `${Math.max(marker.y - 2, 4)}%` })
        .onClick(() => {
          this.selectedId = this.selectedId === marker.id ? -1 : marker.id;
        })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  SelectedCard() {
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
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }

  @Builder
  BottomBar() {
    Row({ space: AppSpacing.md }) {
      Button('Reset')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .layoutWeight(1)
        .height(48)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(12)
        .onClick(() => {
          this.resetForm();
        })
      Button('Save Asset')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .layoutWeight(1)
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
    }
    .width('100%')
    .height(72)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#24000000', offsetY: -2 })
  }

  build() {
    Column() {
      Row() {
        Text('Asset Inventory')
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(68)
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Row({ space: AppSpacing.sm }) {
            this.FilterChip('Warehouse', this.warehouseOn)
            this.FilterChip('Device', this.deviceOn)
            this.FilterChip('Office', this.officeOn)
          }
          .width('100%')

          Column({ space: AppSpacing.md }) {
            TextInput({ text: this.assetName, placeholder: 'Asset Name' })
              .onChange((value: string) => {
                this.assetName = value;
              })
              .width('100%')
            TextInput({ text: this.assetCode, placeholder: 'Asset Code' })
              .onChange((value: string) => {
                this.assetCode = value;
              })
              .width('100%')
            TextInput({ text: this.assetType, placeholder: 'Asset Type' })
              .onChange((value: string) => {
                this.assetType = value;
              })
              .width('100%')
            this.SelectedCard()
          }
          .width('100%')

          Stack() {
            this.MapGridOverlay()
            ForEach(this.markers, (marker: AssetMarker) => {
              if (this.isCategoryOn(marker.type)) {
                this.MapMarker(marker)
              }
            })
          }
          .width('100%')
          .aspectRatio(0.9)
          .backgroundColor(AppColors.surface)
          .borderRadius(16)
          .border({ width: 1, color: AppColors.outline })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
