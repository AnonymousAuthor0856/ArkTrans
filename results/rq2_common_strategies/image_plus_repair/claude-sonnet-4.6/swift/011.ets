interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  warning: string;
  onPrimary: string;
  onSurface: string;
}

const Colors: ColorTokens = {
  primary: '#00E5FF',
  secondary: '#FF00AA',
  tertiary: '#76FF03',
  background: '#101024',
  surface: '#1C1C3A',
  surfaceVariant: '#282850',
  outline: '#444469',
  warning: '#FFD600',
  onPrimary: '#000000',
  onSurface: '#E0E0FF',
};

interface AuthorData {
  name: string;
  avatarColor: string;
}

interface ReplyData {
  id: number;
  author: AuthorData;
  timestamp: string;
  text: string;
  votes: number;
}

interface PostData {
  author: AuthorData;
  timestamp: string;
  title: string;
  body: string;
  votes: number;
  commentCount: number;
}

@Component
struct DiamondShape {
  color: string = Colors.outline;
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  build() {
    Canvas(this.ctx)
      .width(28)
      .height(28)
      .onReady(() => {
        this.ctx.fillStyle = this.color;
        this.ctx.beginPath();
        this.ctx.moveTo(14, 0);
        this.ctx.lineTo(28, 14);
        this.ctx.lineTo(14, 28);
        this.ctx.lineTo(0, 14);
        this.ctx.closePath();
        this.ctx.fill();
      })
  }
}

@Component
struct DiamondShapeDown {
  color: string = Colors.outline;
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  build() {
    Canvas(this.ctx)
      .width(28)
      .height(28)
      .onReady(() => {
        this.ctx.fillStyle = this.color;
        this.ctx.beginPath();
        this.ctx.moveTo(14, 28);
        this.ctx.lineTo(28, 14);
        this.ctx.lineTo(14, 0);
        this.ctx.lineTo(0, 14);
        this.ctx.closePath();
        this.ctx.fill();
      })
  }
}

@Component
struct AuthorInfo {
  authorName: string = '';
  authorColor: string = '';
  timestamp: string = '';

  build() {
    Row({ space: 10 }) {
      Stack() {
        Circle()
          .width(28)
          .height(28)
          .fill(this.authorColor)
        Circle()
          .width(10)
          .height(10)
          .fill('#33000000')
      }

      Text(this.authorName)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.authorColor)

      Text(this.timestamp)
        .fontSize(14)
        .fontColor(Colors.outline)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct ForumPostView {
  @State voteState: number = 1;
  @State commentText: string = '';

  private post: PostData = {
    author: { name: 'user/compose_master', avatarColor: Colors.tertiary },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    votes: 1337,
    commentCount: 42
  };

  private replies: ReplyData[] = [
    {
      id: 1,
      author: { name: 'dev/android_fan', avatarColor: Colors.secondary },
      timestamp: '7h ago',
      text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.',
      votes: 25
    },
    {
      id: 2,
      author: { name: 'ux/designer_jane', avatarColor: Colors.primary },
      timestamp: '5h ago',
      text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.',
      votes: 18
    }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button() {
          Text('←')
            .fontSize(24)
            .fontColor(Colors.primary)
            .fontWeight(FontWeight.Bold)
        }
        .backgroundColor(Color.Transparent)
        .width(50)
        .height(50)

        Blank()

        Text('r/jetpackcompose')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Blank()

        Row().width(50).height(50)
      }
      .width('100%')
      .height(60)
      .padding({ left: 20, right: 20 })
      .backgroundColor(Colors.surface)

      // Scrollable content
      Scroll() {
        Column() {
          // Post Card
          Row({ space: 16 }) {
            // Vote column
            Column({ space: 10 }) {
              DiamondShape({ color: this.voteState === 1 ? Colors.secondary : Colors.outline })
                .onClick(() => {
                  this.voteState = this.voteState === 1 ? 0 : 1;
                })

              Text(`${this.post.votes + this.voteState - 1}`)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.voteState !== 0 ? Colors.secondary : Colors.onSurface)

              DiamondShapeDown({ color: this.voteState === -1 ? Colors.primary : Colors.outline })
                .onClick(() => {
                  this.voteState = this.voteState === -1 ? 0 : -1;
                })
            }
            .width(60)
            .alignItems(HorizontalAlign.Center)

            // Post content
            Column({ space: 10 }) {
              AuthorInfo({
                authorName: this.post.author.name,
                authorColor: this.post.author.avatarColor,
                timestamp: this.post.timestamp
              })

              Text(this.post.title)
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)
                .width('100%')

              Text(this.post.body)
                .fontSize(18)
                .fontColor('#CCE0E0FF')
                .width('100%')

              Row({ space: 28 }) {
                Text(`${this.post.commentCount} Comments`)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.outline)
                Text('Share')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.outline)
              }
              .margin({ top: 10 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .padding(20)
          .width('100%')
          .alignItems(VerticalAlign.Top)
          .backgroundColor(Colors.surface)

          // TOP COMMENTS label
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.outline)
            .width('100%')
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })

          // Reply cards
          ForEach(this.replies, (reply: ReplyData) => {
            Row({ space: 16 }) {
              // Left color bar
              Column()
                .width(3)
                .height('100%')
                .backgroundColor(reply.author.avatarColor)
                .borderRadius(1.5)
                .opacity(0.5)

              Column({ space: 6 }) {
                AuthorInfo({
                  authorName: reply.author.name,
                  authorColor: reply.author.avatarColor,
                  timestamp: reply.timestamp
                })

                Text(reply.text)
                  .fontSize(18)
                  .fontColor('#E6E0E0FF')
                  .width('100%')

                Row({ space: 16 }) {
                  Text(`${reply.votes} votes`)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.outline)
                  Text('Reply')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.outline)
                }
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })
            .width('100%')
            .alignItems(VerticalAlign.Top)
          }, (reply: ReplyData) => reply.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(Colors.background)
      .scrollBar(BarState.Off)

      // Bottom comment bar
      Column() {
        Divider()
          .color('#4D444469')
          .margin({ left: 20, right: 20 })

        Row({ space: 16 }) {
          Stack({ alignContent: Alignment.Start }) {
            TextInput({ placeholder: 'Add a comment...', text: this.commentText })
              .placeholderColor(Colors.outline)
              .placeholderFont({ size: 18 })
              .fontSize(18)
              .fontColor(Colors.onSurface)
              .backgroundColor(Colors.surfaceVariant)
              .borderRadius(20)
              .height(52)
              .padding({ left: 20, right: 20 })
              .onChange((value: string) => {
                this.commentText = value;
              })
          }
          .layoutWeight(1)

          Button('POST')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onPrimary)
            .backgroundColor(Colors.primary)
            .borderRadius(20)
            .height(52)
            .padding({ left: 20, right: 20 })
        }
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor(Colors.surface)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}