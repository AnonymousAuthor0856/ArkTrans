interface ColorTokens {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  onSurface: string
  muted: string
  black: string
}

const C: ColorTokens = {
  primary: '#00E5FF',
  secondary: '#FF00AA',
  tertiary: '#76FF03',
  background: '#101024',
  surface: '#1C1C3A',
  surfaceVariant: '#28284F',
  outline: '#45456A',
  onSurface: '#E0E0FF',
  muted: '#B8B8D8',
  black: '#000000'
}

interface Author {
  name: string
  avatarColor: string
}

interface Reply {
  id: number
  author: Author
  timestamp: string
  text: string
  votes: number
}

interface Post {
  author: Author
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number
}

@Entry
@Component
struct ForumPostApp {
  @State voteState: number = 1
  @State commentText: string = ''

  private post: Post = {
    author: { name: 'user/\ncompose_master', avatarColor: C.tertiary },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    votes: 1337,
    commentCount: 42
  }

  private replies: Reply[] = [
    {
      id: 1,
      author: { name: 'dev/android_fan', avatarColor: C.secondary },
      timestamp: '7h ago',
      text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.',
      votes: 25
    },
    {
      id: 2,
      author: { name: 'ux/designer_jane', avatarColor: C.primary },
      timestamp: '5h ago',
      text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.',
      votes: 18
    }
  ]

  build() {
    Column() {
      this.topBar()

      Scroll() {
        Column() {
          this.postCard()

          Text('TOP COMMENTS')
            .fontSize(16)
            .fontColor(C.outline)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .padding({ left: 20, right: 20, top: 20, bottom: 12 })

          ForEach(this.replies, (reply: Reply) => {
            this.replyCard(reply)
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(C.background)

      this.commentBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C.background)
  }

  @Builder
  topBar() {
    Row() {
      Button() {
        Text('←')
          .fontSize(48)
          .fontWeight(FontWeight.Lighter)
          .fontColor(C.primary)
          .lineHeight(48)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .width(50)
      .height(50)
      .padding(0)

      Text('r/jetpackcompose')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(C.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Blank()
        .width(50)
    }
    .width('100%')
    .height(60)
    .padding({ left: 20, right: 20 })
    .backgroundColor(C.surface)
  }

  @Builder
  voteArrow(color: string, flipped: boolean = false) {
    Text('◆')
      .fontSize(28)
      .fontColor(color)
      .rotate({ angle: flipped ? 180 : 0 })
      .width(30)
      .height(30)
      .textAlign(TextAlign.Center)
  }

  @Builder
  avatar(author: Author) {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(28)
        .height(28)
        .fill(author.avatarColor)
      Circle()
        .width(10)
        .height(10)
        .fill('#33000000')
    }
    .width(28)
    .height(28)
  }

  @Builder
  authorInfo(author: Author, timestamp: string) {
    Row({ space: 10 }) {
      this.avatar(author)

      Text(author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(author.avatarColor)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)

      Text(timestamp)
        .fontSize(14)
        .fontColor(C.outline)
        .maxLines(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  postCard() {
    Row({ space: 16 }) {
      Column({ space: 10 }) {
        Button() {
          this.voteArrow(this.voteState === 1 ? C.secondary : C.outline)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .padding(0)
        .width(40)
        .height(32)
        .onClick(() => {
          this.voteState = this.voteState === 1 ? 0 : 1
        })

        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? C.secondary : C.onSurface)
          .width(60)
          .textAlign(TextAlign.Center)

        Button() {
          this.voteArrow(this.voteState === -1 ? C.primary : C.outline, true)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .padding(0)
        .width(40)
        .height(32)
        .onClick(() => {
          this.voteState = this.voteState === -1 ? 0 : -1
        })
      }
      .width(60)
      .alignItems(HorizontalAlign.Center)

      Column({ space: 10 }) {
        this.authorInfo(this.post.author, this.post.timestamp)

        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(C.onSurface)
          .lineHeight(27)
          .width('100%')

        Text(this.post.body)
          .fontSize(18)
          .fontColor('#CCCCDFFF')
          .lineHeight(29)
          .width('100%')

        Row({ space: 28 }) {
          Text(`${this.post.commentCount} Comments`)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(C.outline)
          Text('Share')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(C.outline)
        }
        .margin({ top: 8 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(C.surface)
  }

  @Builder
  replyCard(reply: Reply) {
    Row({ space: 16 }) {
      Divider()
        .vertical(true)
        .width(3)
        .height(150)
        .color(reply.author.avatarColor)
        .opacity(0.5)

      Column({ space: 6 }) {
        this.authorInfo(reply.author, reply.timestamp)

        Text(reply.text)
          .fontSize(18)
          .fontColor('#D0D0E8')
          .lineHeight(29)
          .width('100%')

        Row({ space: 16 }) {
          Text(`${reply.votes} votes`)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(C.outline)
          Text('Reply')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(C.outline)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 12, bottom: 12 })
  }

  @Builder
  commentBar() {
    Column({ space: 0 }) {
      Divider()
        .height(1)
        .color(C.outline)
        .opacity(0.3)
        .margin({ left: 20, right: 20 })

      Row({ space: 16 }) {
        TextInput({ text: this.commentText, placeholder: 'Add a comment...' })
          .fontSize(18)
          .fontColor(C.onSurface)
          .placeholderColor(C.outline)
          .backgroundColor(C.surfaceVariant)
          .borderRadius(20)
          .height(52)
          .padding({ left: 20, right: 20 })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.commentText = value
          })

        Button('POST')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(C.black)
          .backgroundColor(C.primary)
          .borderRadius(20)
          .height(52)
          .width(168)
          .onClick(() => {
            this.commentText = ''
          })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
    }
    .width('100%')
    .backgroundColor(C.surface)
  }
}
