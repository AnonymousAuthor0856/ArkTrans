// ============================================================
// File Manager — ArkTS / ArkUI  (converted from SwiftUI)
// Entry page file, e.g.  entry/src/main/ets/pages/Index.ets
// ============================================================

// MARK: - AppTokens

// Colors (Kotlin ARGB 0xFF…… -> '#RRGGBB')
const COLOR_PRIMARY: string = '#111111';
const COLOR_SECONDARY: string = '#333333';
const COLOR_TERTIARY: string = '#555555';
const COLOR_BACKGROUND: string = '#FFFFFF';
const COLOR_SURFACE: string = '#F9F9F9';
const COLOR_SURFACE_VARIANT: string = '#EAEAEA';
const COLOR_OUTLINE: string = '#D0D0D0';
const COLOR_SUCCESS: string = '#16A34A';
const COLOR_WARNING: string = '#F59E0B';
const COLOR_ERROR: string = '#DC2626';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SECONDARY: string = '#FFFFFF';
const COLOR_ON_TERTIARY: string = '#FFFFFF';
const COLOR_ON_BACKGROUND: string = '#111111';
const COLOR_ON_SURFACE: string = '#111111';

// Typography (size in fp, weight -> FontWeight)
const FONT_DISPLAY_SIZE: number = 26;
const FONT_TITLE_SIZE: number = 18;
const FONT_BODY_SIZE: number = 14;
const FONT_LABEL_SIZE: number = 12;

// Shapes (corner radius in vp)
const SHAPE_SMALL: number = 6;
const SHAPE_MEDIUM: number = 10;
const SHAPE_LARGE: number = 14;

// Spacing (in vp)
const SPACING_SM: number = 8;
const SPACING_MD: number = 12;
const SPACING_LG: number = 16;
const SPACING_XL: number = 24;

// Top app bar height including the status-bar region
const TOTAL_APP_BAR_HEIGHT: number = 100;

// MARK: - Elevation tokens
// ShadowSpec(elevation, radius, dy, opacity) -> ShadowOptions
// Kotlin level1 = ShadowSpec(2dp, 4dp, 2dp, 0.12f)
const ELEVATION_LEVEL1_RADIUS: number = 4;
const ELEVATION_LEVEL1_DY: number = 2;
const ELEVATION_LEVEL1_COLOR: string = '#1F000000'; // 0.12 * 255 ≈ 0x1F

// Kotlin level2 = ShadowSpec(4dp, 8dp, 4dp, 0.16f)
const ELEVATION_LEVEL2_RADIUS: number = 8;
const ELEVATION_LEVEL2_DY: number = 4;
const ELEVATION_LEVEL2_COLOR: string = '#29000000'; // 0.16 * 255 ≈ 0x29

// MARK: - Data Model

interface FileItem {
  name: string;
  type: string;
  size: string;
}

const FILE_LIST: FileItem[] = [
  { name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
  { name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
  { name: 'Design.psd', type: 'Image', size: '4.7 MB' },
  { name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
  { name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
];

// MARK: - Components

/**
 * Replaces the Kotlin Compose `Box` badge that shows the file type.
 */
@Component
struct BoxView {
  @Prop text: string = '';

  build() {
    Text(this.text)
      .fontSize(FONT_BODY_SIZE)
      .fontWeight(FontWeight.Normal)
      .fontColor(COLOR_ON_SURFACE)
      .textAlign(TextAlign.Center)
      .width('100%')
      .height(24)
      .backgroundColor(COLOR_SURFACE_VARIANT)
      .borderRadius(SHAPE_MEDIUM)
  }
}

/**
 * Replaces the Kotlin Compose `Card` that shows a single file.
 * Arrangement.SpaceBetween -> Column + Blank()
 */
@Component
struct FileCard {
  @Prop name: string = '';
  @Prop type: string = '';
  @Prop size: string = '';

  build() {
    Column() {
      BoxView({ text: this.type })

      // SpaceBetween spacer
      Blank()

      Column({ space: 2 }) {
        Text(this.name)
          .fontSize(FONT_TITLE_SIZE)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
          .textAlign(TextAlign.Start)

        Text(this.size)
          .fontSize(FONT_LABEL_SIZE)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_TERTIARY)
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(SPACING_MD)
    .width('100%')
    .height(120)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(SHAPE_LARGE)
    .shadow({
      radius: ELEVATION_LEVEL1_RADIUS,
      color: ELEVATION_LEVEL1_COLOR,
      offsetX: 0,
      offsetY: ELEVATION_LEVEL1_DY
    })
  }
}

// MARK: - Root Screen

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // CenterAlignedTopAppBar replacement, ignores the top safe area
      Stack() {
        Text('File Manager')
          .fontSize(FONT_DISPLAY_SIZE)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(TOTAL_APP_BAR_HEIGHT)
      .backgroundColor(COLOR_BACKGROUND)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

      // Main content
      Column({ space: SPACING_LG }) {
        Text('Recent Files')
          .fontSize(FONT_TITLE_SIZE)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_PRIMARY)

        // LazyVGrid: 2 flexible columns, medium gaps
        Grid() {
          ForEach(FILE_LIST, (item: FileItem) => {
            GridItem() {
              FileCard({
                name: item.name,
                type: item.type,
                size: item.size
              })
            }
          }, (item: FileItem) => item.name + item.type)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(SPACING_MD)
        .rowsGap(SPACING_MD)
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(SPACING_LG)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(COLOR_BACKGROUND)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
  }
}