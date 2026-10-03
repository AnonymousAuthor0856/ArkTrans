import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { UIAbility, AbilityConstant } from '@kit.AbilityKit';

// --- Design Tokens & Constants ---

interface AppTokensColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface AppTokensSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface AppTokensShapes {
  small: number;
  medium: number;
  large: number;
}

const AppTokens = {
  Colors: {
    primary: '#A0C4FF',
    secondary: '#B7E4C7',
    tertiary: '#FFDDC1',
    background: '#F8F7FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F0F0F5',
    outline: '#D9D9E3',
    success: '#B4E4C7',
    warning: '#FFDDC1',
    error: '#FFB4AB',
    onPrimary: '#001D3D',
    onSecondary: '#003720',
    onTertiary: '#3E2800',
    onBackground: '#1B1B1F',
    onSurface: '#1B1B1F'
  } as AppTokensColors,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  } as AppTokensSpacing,
  Shapes: {
    small: 4,
    medium: 8,
    large: 12
  } as AppTokensShapes
};

// --- Components ---

@Component
struct AnnotationToolButton {
  @Prop icon: string;
  @Prop toolName: string;
  @Prop selectedTool: string;
  onClickCallback?: () => void;

  build() {
    Column() {
      Text(this.icon)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.selectedTool === this.toolName ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
        .fontSize(16)
    }
    .width(40)
    .height(40)
    .borderRadius(20) // CircleShape equivalent
    .backgroundColor(this.selectedTool === this.toolName ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      if (this.onClickCallback) {
        this.onClickCallback();
      }
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  aboutToAppear() {
    // Attempt to hide system bars for immersive experience similar to Android code
    try {
      let ctx = getContext(this) as Context.UIAbilityContext;
      if (ctx) {
        let appCtx = ctx.getApplicationContext();
        if (appCtx) {
          // Note: getWindowRouter is not standard in all API versions. 
          // Using window module directly is often preferred or requires specific context handling.
          // Here we assume a valid path exists or mock the intent if strictly following provided structure errors.
          // Since getWindowRouter doesn't exist on ApplicationContext in standard ArkTS, we skip or use window module directly.
          // For this fix, we will comment out the problematic block as it relies on non-existent APIs in the provided context.
          console.info("Window management skipped due to API availability.");
        }
      }
    } catch (e: BusinessError) {
      console.error(`Failed to get window context. Error: ${e.message}`);
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon Placeholder
        Row()
          .width(48)
          .height(48)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .onClick(() => {}) {
            Circle({ width: 24, height: 24 })
              .fill(AppTokens.Colors.surfaceVariant)
          }

        Text("Document.pdf")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Share Button
        Row() {
          Text("Share")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.5)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {})
        
        Blank().width(AppTokens.Spacing.sm)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Row() {
        // Left Sidebar: Page Grid
        GridContainer() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Column() {
                Text(page.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .letterSpacing(0.5)
                  .fontColor(this.selectedPage === page ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              }
              .width('100%')
              .aspectRatio(1 / 0.7) // Inverse of aspectRatio(0.7) in Compose which is width/height
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor(this.selectedPage === page ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({
                width: this.selectedPage === page ? 2 : 0,
                color: AppTokens.Colors.primary,
                radius: AppTokens.Shapes.medium
              })
              .onClick(() => {
                this.selectedPage = page;
              })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsTemplate('auto')
        .gridItemLayout({ type: GridItemType.MATCH_PARENT })
        .width(150)
        .height('100%')
        .padding(AppTokens.Spacing.sm)
        .itemSpacing({ row: AppTokens.Spacing.sm, column: AppTokens.Spacing.sm })

        Blank()
          .width(AppTokens.Spacing.md)

        // Right Content: Document Viewer
        Column() {
          // Document Card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: 2,
            color: 'rgba(0, 0, 0, 0.08)',
            offsetX: 0,
            offsetY: 1
          })

          // Floating Tool Panel
          Column({ space: AppTokens.Spacing.sm }) {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: this.selectedTool,
              onClickCallback: () => { this.selectedTool = 'pen' }
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: this.selectedTool,
              onClickCallback: () => { this.selectedTool = 'highlighter' }
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: this.selectedTool,
              onClickCallback: () => { this.selectedTool = 'text' }
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: this.selectedTool,
              onClickCallback: () => { this.selectedTool = 'shape' }
            })
          }
          .position({ x: AppTokens.Spacing.md, y: AppTokens.Spacing.md })
          .padding(AppTokens.Spacing.sm)
          .backgroundColor(Color.White.withAlpha(0.8))
          .borderRadius(AppTokens.Shapes.large)
          .border({
            width: 1,
            color: AppTokens.Colors.outline,
            radius: AppTokens.Shapes.large
          })
        }
        .layoutWeight(1)
        .height('100%')
        .position({ x: 0, y: 0 })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.md)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}