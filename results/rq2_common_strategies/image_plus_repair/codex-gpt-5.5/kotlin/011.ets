class Author {
  name: string
  avatarColor: string

  constructor(name: string, avatarColor: string) {
    this.name = name
    this.avatarColor = avatarColor
  }
}

class Reply {
  id: number
  author: Author
  timestamp: string
  text: string
  votes: number

  constructor(id: number, author: Author, timestamp: string, text: string, votes: number) {
    this.id = id
    this.author = author
    this.timestamp = timestamp
    this.text = text
    this.votes = votes
  }
}

class ForumPost {
  author: Author
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number

  constructor(author: Author, timestamp: string, title: string, body: string, votes: number, commentCount: number) {
    this.author = author
    this.timestamp = timestamp
    this.title = title
    this.body = body
    this.votes = votes
    this.commentCount = commentCount
  }
}

class AppColors {
  static readonly primary: string = '#00E5FF'
  static readonly secondary: string = '#FF00AA'
  static readonly tertiary: string = '#76FF03'
  static readonly background: string = '#101024'
  static readonly surface: string = '#1C1C3A'
  static readonly surfaceDeep: string = '#0E0E22'
  static readonly surfaceVariant: string = '#282850'
  static readonly composer: string = '#173D5C'
  static readonly outline: string = '#55557A'
  static readonly onSurface: string = '#E0E0FF'
  static readonly onMuted: string = '#C9C8E9'
  static readonly onPrimary: string = '#000000'
  static readonly warning: string = '#FFD600'
}

@Entry
@Component
struct ForumPostPage {
  @State voteState: number = 1

  private post: ForumPost = new ForumPost(
    new Author('user/compose_master', AppColors.tertiary),
    '8 hours\nago',
    'The power of Jetpack\nCompose for single-file\nUIs',
    'Creating fully functional, beautiful UIs\nin a single Kotlin file is not just\npossible, it\'s becoming a new\nstandard for prototypes and\nminimalist apps. What are your\nthoughts on this approach?',
    1337,
    42
  )

  private replies: Reply[] = [
    new Reply(1, new Author('dev/android_fan', AppColors.secondary), '7h ago', 'Absolutely agree! It simplifies dependency\nmanagement and makes sharing snippets a\nbreeze.', 25),
    new Reply(2, new Author('ux/designer_jane', AppColors.primary), '5h ago', 'From a design perspective, having the design\ntokens and theme right next to the UI components\nis a game-changer for consistency.', 18),
    new Reply(3, new Author('newbie/coder', AppColors.warning), '2h ago', 'I found it a bit overwhelming at first. Any tips\nfor organizing the file?', 3)
  ]

  @Builder
  BackIcon() {
    Stack() {
      Rect()
        .width(42)
        .height(4)
        .fill(AppColors.primary)
        .rotate({ angle: 0 })
        .translate({ x: 5, y: 0 })
      Rect()
        .width(31)
        .height(4)
        .fill(AppColors.primary)
        .rotate({ angle: -45 })
        .translate({ x: -7, y: -11 })
      Rect()
        .width(31)
        .height(4)
        .fill(AppColors.primary)
        .rotate({ angle: 45 })
        .translate({ x: -7, y: 11 })
    }
    .width(64)
    .height(64)
  }

  @Builder
  VoteDiamond(color: string) {
    Rect()
      .width(34)
      .height(34)
      .fill(color)
      .rotate({ angle: 45 })
  }

  @Builder
  Avatar(author: Author, size: number = 48) {
    Stack() {
      Circle()
        .width(size)
        .height(size)
        .fill(author.avatarColor)
      Circle()
        .width(size * 0.62)
        .height(size * 0.62)
        .fill(Color.Black)
        .opacity(0.2)
    }
    .width(size)
    .height(size)
  }

  @Builder
  AuthorInfo(author: Author, timestamp: string) {
    Row({ space: 16 }) {
      this.Avatar(author, 48)
      Text(author.name)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(author.avatarColor)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)
      Text(timestamp)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .lineHeight(33)
        .fontColor(AppColors.outline)
        .width(118)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoChip(text: string) {
    Text(text)
      .fontSize(25)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.outline)
  }

  @Builder
  PostCard(post: ForumPost) {
    Row() {
      Column({ space: 34 }) {
        Button({ type: ButtonType.Normal }) {
          this.VoteDiamond(this.voteState === 1 ? AppColors.secondary : AppColors.outline)
        }
        .width(80)
        .height(80)
        .backgroundColor(Color.Transparent)
        .padding(0)
        .onClick(() => {
          this.voteState = this.voteState === 1 ? 0 : 1
        })

        Text((post.votes + this.voteState - 1).toString())
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppColors.secondary : AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width(92)

        Button({ type: ButtonType.Normal }) {
          this.VoteDiamond(this.voteState === -1 ? AppColors.primary : AppColors.outline)
        }
        .width(80)
        .height(80)
        .backgroundColor(Color.Transparent)
        .padding(0)
        .onClick(() => {
          this.voteState = this.voteState === -1 ? 0 : -1
        })
      }
      .width(112)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 90 })

      Column() {
        this.AuthorInfo(post.author, post.timestamp)

        Text(post.title)
          .fontSize(44)
          .lineHeight(53)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .margin({ top: 22 })

        Text(post.body)
          .fontSize(32)
          .lineHeight(48)
          .fontColor(AppColors.onMuted)
          .margin({ top: 18 })

        Row({ space: 66 }) {
          this.InfoChip(`${post.commentCount} Comments`)
          this.InfoChip('Share')
        }
        .margin({ top: 44 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .padding({ left: 24, right: 28, top: 78, bottom: 31 })
  }

  @Builder
  ReplyCard(reply: Reply) {
    Row() {
      Blank()
        .width(4)
        .height('100%')
        .backgroundColor(reply.author.avatarColor)
        .opacity(0.55)
        .borderRadius(4)

      Column() {
        Row({ space: 16 }) {
          this.Avatar(reply.author, 48)
          Text(reply.author.name)
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(reply.author.avatarColor)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text(reply.timestamp)
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.outline)
        }
        .alignItems(VerticalAlign.Center)

        Text(reply.text)
          .fontSize(30)
          .lineHeight(48)
          .fontColor(AppColors.onSurface)
          .opacity(0.92)
          .margin({ top: 22 })

        Row({ space: 28 }) {
          this.InfoChip(`${reply.votes} votes`)
          this.InfoChip('Reply')
        }
        .margin({ top: 12 })
      }
      .layoutWeight(1)
      .padding({ left: 22 })
    }
    .width('100%')
    .height(218)
    .padding({ left: 32, right: 32 })
    .margin({ top: 24 })
  }

  @Builder
  TopBar() {
    Row({ space: 24 }) {
      this.BackIcon()
      Text('r/jetpackcompose')
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
        .margin({ right: 64 })
    }
    .width('100%')
    .height(128)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 22, right: 22, top: 8 })
    .backgroundColor(AppColors.surface)
  }

  @Builder
  BottomComposer() {
    Row({ space: 24 }) {
      Text('Add a comment...')
        .height(96)
        .layoutWeight(1)
        .borderRadius(28)
        .backgroundColor(AppColors.surfaceVariant)
        .fontSize(30)
        .fontColor(AppColors.outline)
        .padding({ left: 32 })
        .textAlign(TextAlign.Start)

      Button('POST')
        .width(140)
        .height(96)
        .borderRadius(28)
        .backgroundColor(AppColors.primary)
        .fontSize(27)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
    }
    .width('100%')
    .height(144)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 32, right: 32, top: 16, bottom: 24 })
    .backgroundColor(AppColors.composer)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column() {
            this.PostCard(this.post)

            Text('TOP COMMENTS')
              .width('100%')
              .fontSize(26)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
              .fontColor(AppColors.outline)
              .backgroundColor(AppColors.surfaceDeep)
              .padding({ left: 32, top: 16, bottom: 8 })

            ForEach(this.replies, (reply: Reply) => {
              this.ReplyCard(reply)
            }, (reply: Reply) => reply.id.toString())

            Blank()
              .height(156)
          }
          .width('100%')
          .backgroundColor(AppColors.surfaceDeep)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      this.BottomComposer()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
