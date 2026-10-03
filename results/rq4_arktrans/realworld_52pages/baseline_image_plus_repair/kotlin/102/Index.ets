// entry/src/main/ets/viewmodel/NoteData.ts
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

// entry/src/main/ets/components/AppTheme.ets
import { Colors } from '@kit.ArkUI';

export class AppTokens {
  static readonly Colors = {
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
}

@Entry
@Component
struct HomeScreen {
  @State notes: NoteItem[] = sampleNotes;

  build() {
    Column() {
      // Top Bar
      Row() {
        // Menu Icon (Hamburger)
        Image($r('app.media.ic_menu')) // Placeholder for menu icon
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
          .onClick(() => {
            // Handle menu click
          })

        Text('Notes')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: 16 })

        Blank()

        // Search Icon
        Image($r('app.media.ic_search')) // Placeholder for search icon
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
          .onClick(() => {
            // Handle search click
          })

        // Grid View Icon
        Image($r('app.media.ic_grid_view')) // Placeholder for grid view icon
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
          .margin({ left: 16 })
          .onClick(() => {
            // Handle grid view toggle
          })

        // More Options Icon (Vertical Dots)
        Image($r('app.media.ic_more_vert')) // Placeholder for more options icon
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
          .margin({ left: 16 })
          .onClick(() => {
            // Handle more options click
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(AppTokens.Colors.surface)

      // Notes List
      List({ space: 16 }) {
        ForEach(this.notes, (note: NoteItem) => {
          ListItem() {
            Column() {
              Text(note.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text(note.content)
                .fontSize(14)
                .fontColor(AppTokens.Colors.onSurfaceVariant)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ top: 4 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(12)
            .shadow({ radius: 2, color: '#00000010', offsetY: 2 })
          }
        }, (item: NoteItem) => item.title)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 16 })
      .backgroundColor(AppTokens.Colors.background)

      // Floating Action Button
      RelativeContainer() {
        Column() {
          Image($r('app.media.ic_add')) // Placeholder for add icon
            .width(24)
            .height(24)
            .fillColor(AppTokens.Colors.onPrimaryContainer)
        }
        .id('fab')
        .width(56)
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .borderRadius(28)
        .backgroundColor(AppTokens.Colors.primaryContainer)
        .shadow({ radius: 8, color: '#00000020', offsetY: 4 })
        .onClick(() => {
          // Handle create note click
        })
        .position({ align: Alignment.BottomEnd, anchorId: 'root' })
        .margin({ bottom: 24, right: 24 })
      }
      .id('root')
      .width('100%')
      .height(80)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}