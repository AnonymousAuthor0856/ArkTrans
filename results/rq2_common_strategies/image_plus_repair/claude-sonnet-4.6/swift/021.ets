import { window as harmonyWindow } from '@kit.ArkUI';

// Color constants
const COLOR_PRIMARY: string = '#2563EB';
const COLOR_SECONDARY: string = '#60A5FA';
const COLOR_TERTIARY: string = '#3B82F6';
const COLOR_BACKGROUND: string = '#F3F4F6';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#E5E7EB';
const COLOR_OUTLINE: string = '#D1D5DB';
const COLOR_SUCCESS: string = '#16A34A';
const COLOR_WARNING: string = '#F59E0B';
const COLOR_ERROR: string = '#DC2626';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SECONDARY: string = '#1E1E1E';
const COLOR_ON_TERTIARY: string = '#FFFFFF';
const COLOR_ON_BACKGROUND: string = '#1E1E1E';
const COLOR_ON_SURFACE: string = '#1E1E1E';

// Spacing constants
const SPACING_XS: number = 4;
const SPACING_SM: number = 8;
const SPACING_MD: number = 12;
const SPACING_LG: number = 16;
const SPACING_XL: number = 24;

class KanbanColumn {
  id: number = 0;
  title: string = '';
  tasks: string[] = [];

  constructor(id: number, title: string, tasks: string[]) {
    this.id = id;
    this.title = title;
    this.tasks = tasks;
  }
}

const kanbanColumns: KanbanColumn[] = [
  new KanbanColumn(1, 'To Do', ['Write report', 'Design mockup']),
  new KanbanColumn(2, 'In Progress', ['Implement feature X', 'Fix layout bug']),
  new KanbanColumn(3, 'Done', ['Team sync', 'Client feedback']),
];

@Component
struct AssistChipView {
  task: string = '';

  build() {
    Text(this.task)
      .fontSize(14)
      .fontWeight(FontWeight.Normal)
      .fontColor(COLOR_ON_SURFACE)
      .padding({
        left: SPACING_LG,
        right: SPACING_LG,
        top: SPACING_SM,
        bottom: SPACING_SM
      })
      .backgroundColor(COLOR_SURFACE_VARIANT)
      .borderRadius(10)
  }
}

@Component
struct CardView {
  column: KanbanColumn = new KanbanColumn(0, '', []);

  build() {
    Column({ space: SPACING_SM }) {
      Text(this.column.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_PRIMARY)
        .alignSelf(ItemAlign.Start)

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task })
      }, (task: string) => task)

      Blank()
    }
    .padding(SPACING_MD)
    .width(220)
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(14)
    .shadow({
      radius: 8,
      color: '#29000000',
      offsetX: 0,
      offsetY: 4,
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;
  private columns: KanbanColumn[] = kanbanColumns;

  aboutToAppear() {
    try {
      const windowClass = harmonyWindow.getLastWindow(getContext(this));
      windowClass.then((win) => {
        win.setWindowSystemBarEnable([]);
        win.setWindowLayoutFullScreen(true);
      });
    } catch (e) {
      console.error('window error: ' + JSON.stringify(e));
    }
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(COLOR_BACKGROUND)

      Column({ space: 0 }) {
        // Top Bar
        Row() {
          Text('Kanban Board')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({
          left: SPACING_LG,
          right: SPACING_LG,
          top: SPACING_LG,
          bottom: SPACING_MD,
        })
        .backgroundColor(COLOR_BACKGROUND)

        // Main Content
        Column({ space: SPACING_LG }) {
          // Notifications Row
          Row() {
            Text('Notifications')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_SURFACE)

            Blank()

            Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
              .selectedColor(COLOR_PRIMARY)
              .onChange((isOn: boolean) => {
                this.notificationsEnabled = isOn;
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          // Kanban Columns Horizontal Scroll
          Scroll() {
            Row({ space: SPACING_MD }) {
              ForEach(this.columns, (col: KanbanColumn) => {
                CardView({ column: col })
              }, (col: KanbanColumn) => col.id.toString())
            }
            .padding({ top: SPACING_XS, bottom: SPACING_XS })
            .height('100%')
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .layoutWeight(1)

          // Task Completion
          Text('Task Completion')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
            .alignSelf(ItemAlign.Start)

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width('100%')
              .height(8)
              .backgroundColor(COLOR_SURFACE_VARIANT)
              .borderRadius(4)

            Row()
              .width('65%')
              .height(8)
              .backgroundColor(COLOR_PRIMARY)
              .borderRadius(4)
          }
          .width('100%')
          .height(8)
        }
        .padding(SPACING_LG)
        .width('100%')
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
  }
}