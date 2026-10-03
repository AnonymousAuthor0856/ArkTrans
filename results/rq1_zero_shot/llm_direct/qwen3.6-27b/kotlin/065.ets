import { window } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

const AppTokens = {
  Colors: {
    primary: '#111111',
    secondary: '#2A2A2A',
    tertiary: '#474747',
    background: '#F6F6F6',
    surface: '#FFFFFF',
    surfaceVariant: '#EDEDED',
    outline: '#D1D1D1',
    success: '#2E7D32',
    warning: '#B98900',
    error: '#B3261E',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0A0A0A',
    onSurface: '#0A0A0A'
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16
  }
}

interface AssetMarker {
  id: number;
  name: string;
  type: string;
  x: number; // Percentage 0-1
  y: number; // Percentage 0-1
}

@Entry
@Component
struct RootScreen {
  @State categories: string[] = ["Warehouse", "Device", "Office"];
  @State enabledCats: string[] = ["Warehouse", "Device", "Office"];
  
  private markers: AssetMarker[] = [
    { id: 1, name: "Main Warehouse", type: "Warehouse", x: 0.18, y: 0.34 },
    { id: 2, name: "CNC-07", type: "Device", x: 0.52, y: 0.46 },
    { id: 3, name: "HQ Office", type: "Office", x: 0.75, y: 0.62 },
    { id: 4, name: "Spare Parts", type: "Warehouse", x: 0.33, y: 0.78 }
  ];

  @State assetName: string = "";
  @State assetCode: string = "";
  @State assetType: string = "Device";
  @State selectedId: number | null = null;

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Asset Inventory")
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(60)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Main Content Area
      Scroll() {
        Column() {
          // Filter Chips
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.categories, (cat: string) => {
              this.FilterChipItem(cat)
            })
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

          // Split View: Form and Map
          Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Top, justifyContent: FlexAlign.SpaceBetween }) {
            
            // Left Column: Form
            Column() {
              this.TextFieldItem("Asset Name", this.assetName, (val: string) => this.assetName = val)
              this.TextFieldItem("Asset Code", this.assetCode, (val: string) => this.assetCode = val)
              this.TextFieldItem("Asset Type", this.assetType, (val: string) => this.assetType = val)

              // Selected Info Card
              Column() {
                Text("Selected")
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ bottom: 4 })
                
                Text(this.selectedId ? 
                  this.markers.find(m => m.id === this.selectedId)?.name ?? "None" : 
                  "None")
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
              .margin({ top: AppTokens.Spacing.md })
            }
            .flexShrink(1)
            .width('48%')

            Spacer().width(AppTokens.Spacing.lg)

            // Right Column: Map
            Column() {
              this.MapView()
            }
            .flexShrink(1)
            .width('48%')
            .height(360)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
          }
          .width('100%')
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        Button("Reset")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .fontColor(AppTokens.Colors.onSurface)
          .borderRadius(AppTokens.Shapes.medium)
          .height(48)
          .flexGrow(1)
          .onClick(() => {
            this.assetName = ""
            this.assetCode = ""
            this.assetType = "Device"
            this.selectedId = null
          })

        Button("Save Asset")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(48)
          .flexGrow(1)
          .onClick(() => {
            // Save logic placeholder
          })
      }
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.14)', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  TextFieldItem(label: string, value: string, onChange: (val: string) => void) {
    Column() {
      TextInput({ placeholder: label, text: value })
        .type(InputType.Normal)
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.small })
        .padding({ left: 12, top: 12, bottom: 12 })
        .onChange((val: string) => onChange(val))
    }
    .width('100%')
    .margin({ bottom: AppTokens.Spacing.md })
  }

  @Builder
  FilterChipItem(category: string) {
    let isSelected = this.enabledCats.includes(category);
    
    Button(category)
      .type(ButtonType.Normal)
      .backgroundColor(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .fontColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .fontSize(isSelected ? 16 : 14)
      .fontWeight(isSelected ? FontWeight.Medium : FontWeight.Normal)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .onClick(() => {
        if (isSelected) {
          const index = this.enabledCats.indexOf(category);
          if (index > -1) this.enabledCats.splice(index, 1);
        } else {
          this.enabledCats.push(category);
        }
      })
  }

  @Builder
  MapView() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Grid Overlay
      Column() {
        ForEach([1, 2, 3, 4, 5], () => {
          Divider()
            .color(AppTokens.Colors.surfaceVariant)
            .strokeWidth(1)
            .margin({ top: AppTokens.Spacing.xl })
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)

      Row() {
        ForEach([1, 2, 3, 4, 5], () => {
          Divider()
            .vertical(true)
            .color(AppTokens.Colors.surfaceVariant)
            .strokeWidth(1)
            .margin({ left: AppTokens.Spacing.xl })
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)

      // Markers
      ForEach(this.markers.filter(m => this.enabledCats.includes(m.type)), (marker: AssetMarker) => {
        this.MapMarkerComponent(marker)
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MapMarkerComponent(marker: AssetMarker) {
    let isSelected = this.selectedId === marker.id;
    let color = marker.type === 'Warehouse' ? AppTokens.Colors.tertiary : 
                marker.type === 'Device' ? AppTokens.Colors.secondary : AppTokens.Colors.primary;

    Stack({ alignContent: Alignment.TopStart }) {
      // Dot
      Circle()
        .width(isSelected ? 28 : 22)
        .height(isSelected ? 28 : 22)
        .fill(color)
        .border({ width: 2, color: isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface })
      
      // Label Bubble
      Text(marker.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .padding({ left: 8, right: 8, top: 2, bottom: 2 })
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
        .position({ x: 20, y: -4 })
    }
    .position({ 
      x: `${marker.x * 100}%`, 
      y: `${marker.y * 100}%` 
    })
    .onClick(() => {
      this.selectedId = this.selectedId === marker.id ? null : marker.id;
    })
  }
}