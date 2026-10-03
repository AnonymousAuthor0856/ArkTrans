import { Colors } from '@kit.ArkUI';

export interface NoteItem {
  title: string;
  content: string;
}

export const sampleNotes: NoteItem[] = [
  {
    title: "Today's first note",
    content: "Thought of it this morning, jotting it down"
  },
  {
    title: "Weekend shopping list",
    content: "Milk, eggs, bread, butter, cheese, apples, bananas"
  },
  {
    title: "Meeting minutes — Q3 planning",
    content: "Discussed roadmap, next quarter focus on search and sync"
  },
  {
    title: "Book notes",
    content: "Atomic Habits — improve 1% every day, that's 37x in a year"
  },
  {
    title: "Workout plan",
    content: "Monday chest + triceps, Wednesday back + biceps, Friday legs + shoulders"
  }
];

interface ColorTokens {
  primary: string;
  onPrimary: string;
  primaryContainer: string;
  onPrimaryContainer: string;
  secondary: string;
  onSecondary: string;
  secondaryContainer: string;
  onSecondaryContainer: string;
  tertiary: string;
  onTertiary: string;
  tertiaryContainer: string;
  onTertiaryContainer: string;
  error: string;
  onError: string;
  errorContainer: string;
  onErrorContainer: string;
  background: string;
  onBackground: string;
  surface: string;
  onSurface: string;
  surfaceVariant: string;
  onSurfaceVariant: string;
  outline: string;
  outlineVariant: string;
  inverseSurface: string;
  inverseOnSurface: string;
  inversePrimary: string;
  surfaceTint: string;
  surfaceDim: string;
  surfaceBright: string;
  surfaceContainerLowest: string;
  surfaceContainerLow: string;
  surfaceContainer: string;
  surfaceContainerHigh: string;
  surfaceContainerHighest: string;
  warning: string;
  success: string;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

export class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#1E6D3B',
    onPrimary: '#FFFFFF',
    primaryContainer: '#D7F5D9',
    onPrimaryContainer: '#00210A',
    secondary: '#516351',
    onSecondary: '#FFFFFF',
    secondaryContainer: '#D4E8D3',
    onSecondaryContainer: '#0F1F12',
    tertiary: '#3A656F',
    onTertiary: '#FFFFFF',
    tertiaryContainer: '#BDEAF6',
    onTertiaryContainer: '#001F26',
    error: '#BA1A1A',
    onError: '#FFFFFF',
    errorContainer: '#FFDAD6',
    onErrorContainer: '#410002',
    background: '#F8FBF1',
    onBackground: '#191D19',
    surface: '#F8FBF1',
    onSurface: '#191D19',
    surfaceVariant: '#DDE5DA',
    onSurfaceVariant: '#424940',
    outline: '#727970',
    outlineVariant: '#C1C9BE',
    inverseSurface: '#2E322E',
    inverseOnSurface: '#EFF3E9',
    inversePrimary: '#80D786',
    surfaceTint: '#1E6D3B',
    surfaceDim: '#D8DCD3',
    surfaceBright: '#F8FBF1',
    surfaceContainerLowest: '#FFFFFF',
    surfaceContainerLow: '#F2F6EC',
    surfaceContainer: '#ECF0E6',
    surfaceContainerHigh: '#E7EAE0',
    surfaceContainerHighest: '#E1E4DB',
    warning: '#F59E0B',
    success: '#16A34A'
  };

  static readonly Spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };
}

@Entry
@Component
struct HomeScreen {
  @State isGridMode: boolean = true; // Defaulting to grid mode as per screenshot

  build() {
    Column() {
      // Top Bar
      Row() {
        // Menu Icon (Hamburger)
        Image($r('app.media.menu')) // Placeholder for menu icon
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
          .margin({ right: AppTokens.Spacing.md })

        // Title
        Text("Notes")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)

        // Search Icon
        Image($r('app.media.search')) // Placeholder for search icon
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
          .margin({ right: AppTokens.Spacing.lg })

        // Grid/List Toggle Icon
        Image(this.isGridMode ? $r('app.media.grid_view') : $r('app.media.list_view')) 
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
          .onClick(() => {
            this.isGridMode = !this.isGridMode;
          })
          .margin({ right: AppTokens.Spacing.lg })

        // More Options Icon (Vertical Dots)
        Image($r('app.media.more_vert')) // Placeholder for more icon
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)

      // Content Area
      Scroll() {
        if (this.isGridMode) {
          Grid() {
            ForEach(sampleNotes, (note: NoteItem) => {
              GridItem() {
                Column() {
                  Text(note.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(AppTokens.Colors.onSurface)
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  
                  Text(note.content)
                    .fontSize(14)
                    .fontColor(AppTokens.Colors.onSurfaceVariant)
                    .margin({ top: AppTokens.Spacing.xs })
                    .maxLines(4)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                }
                .padding(AppTokens.Spacing.md)
                .width('100%')
              }
            }, (note: NoteItem) => note.title)
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(AppTokens.Spacing.sm)
          .columnsGap(AppTokens.Spacing.sm)
          .padding(AppTokens.Spacing.lg)
        } else {
          // List Mode (Not shown in screenshot but implemented for completeness)
          Column() {
            ForEach(sampleNotes, (note: NoteItem) => {
              Row() {
                Column() {
                  Text(note.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(AppTokens.Colors.onSurface)
                  
                  Text(note.content)
                    .fontSize(14)
                    .fontColor(AppTokens.Colors.onSurfaceVariant)
                    .margin({ top: AppTokens.Spacing.xs })
                }
                .layoutWeight(1)
              }
              .width('100%')
              .padding(AppTokens.Spacing.md)
              .borderWidth({ bottom: 1 })
              .borderColor(AppTokens.Colors.outlineVariant)
            }, (note: NoteItem) => note.title)
          }
          .padding(AppTokens.Spacing.lg)
        }
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      // Floating Action Button
      RelativeContainer() {
        Column() {
          Image($r('app.media.add')) // Placeholder for add icon
            .width(24)
            .height(24)
            .fillColor(AppTokens.Colors.onPrimaryContainer)
        }
        .width(56)
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .borderRadius(16)
        .backgroundColor(AppTokens.Colors.primaryContainer)
        .shadow({ radius: 8, color: '#00000033', offsetY: 4 })
        .position({ right: 16, bottom: 16 })
      }
      .width('100%')
      .height(80)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}