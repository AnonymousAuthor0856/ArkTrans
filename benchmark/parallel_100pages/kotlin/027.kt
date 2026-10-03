package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "028_PDFAnnotator_en"
private const val UI_TYPE = "Productivity"
private const val STYLE_THEME = "Soft Pastel"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFFA0C4FF)
        val secondary = Color(0xFFB7E4C7)
        val tertiary = Color(0xFFFFDDC1)
        val background = Color(0xFFF8F7FF)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFF0F0F5)
        val outline = Color(0xFFD9D9E3)
        val success = Color(0xFFB4E4C7)
        val warning = Color(0xFFFFDDC1)
        val error = Color(0xFFFFB4AB)
        val onPrimary = Color(0xFF001D3D)
        val onSecondary = Color(0xFF003720)
        val onTertiary = Color(0xFF3E2800)
        val onBackground = Color(0xFF1B1B1F)
        val onSurface = Color(0xFF1B1B1F)
    }

    object TypographyTokens {
        val display = TextStyle(fontSize = 45.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal, lineHeight = 20.sp)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium, letterSpacing = 0.5.sp)
    }

    object Shapes {
        val small = RoundedCornerShape(4.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(12.dp)
    }

    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
    }

    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 2.dp, 1.dp, 0.08f)
        val level2 = ShadowSpec(3.dp, 4.dp, 2.dp, 0.10f)
        val level3 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.12f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    headlineLarge = AppTokens.TypographyTokens.display,
    headlineSmall = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelSmall = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val pages = (1..12).toList()
    var selectedPage by remember { mutableStateOf(1) }
    var selectedTool by remember { mutableStateOf("pen") }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        containerColor = AppTokens.Colors.background,
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Document.pdf", style = MaterialTheme.typography.titleMedium) },
                navigationIcon = { IconButton(onClick = {}) { Box(Modifier.size(24.dp).background(AppTokens.Colors.surfaceVariant, CircleShape)) } },
                actions = { 
                    Button(onClick = {}, colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary)) {
                        Text("Share", style = MaterialTheme.typography.labelSmall.copy(color = AppTokens.Colors.onPrimary))
                    }
                    Spacer(modifier = Modifier.width(AppTokens.Spacing.sm))
                 }
            )
        }
    ) { paddingValues ->
        Row(
            Modifier.fillMaxSize().padding(paddingValues).padding(AppTokens.Spacing.md)
        ) {
            LazyVerticalGrid(
                columns = GridCells.Fixed(2),
                modifier = Modifier.width(150.dp).fillMaxHeight(),
                contentPadding = PaddingValues(AppTokens.Spacing.sm),
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
            ) {
                items(pages) { page ->
                    Card(
                        onClick = { selectedPage = page },
                        modifier = Modifier.aspectRatio(0.7f),
                        shape = AppTokens.Shapes.medium,
                        colors = CardDefaults.cardColors(containerColor = if (selectedPage == page) AppTokens.Colors.primary else AppTokens.Colors.surfaceVariant),
                        border = if (selectedPage == page) BorderStroke(2.dp, AppTokens.Colors.primary) else null
                    ) {
                        Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                            Text(page.toString(), style = MaterialTheme.typography.labelSmall, color = if(selectedPage == page) AppTokens.Colors.onPrimary else AppTokens.Colors.onSurface)
                        }
                    }
                }
            }
            
            Spacer(modifier = Modifier.width(AppTokens.Spacing.md))

            Box(Modifier.weight(1f).fillMaxHeight()) {
                Card(
                    modifier = Modifier.fillMaxSize(),
                    shape = AppTokens.Shapes.large,
                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                    elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation)
                ) {
                    Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                        Text("Page $selectedPage", style = MaterialTheme.typography.headlineSmall)
                    }
                }

                Column(
                    modifier = Modifier.align(Alignment.CenterStart).padding(AppTokens.Spacing.md)
                        .background(AppTokens.Colors.surface.copy(alpha=0.8f), AppTokens.Shapes.large)
                        .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
                        .padding(AppTokens.Spacing.sm),
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                ) {
                    AnnotationToolButton(icon = "P", toolName = "pen", selectedTool = selectedTool, onClick = { selectedTool = "pen" })
                    AnnotationToolButton(icon = "H", toolName = "highlighter", selectedTool = selectedTool, onClick = { selectedTool = "highlighter" })
                    AnnotationToolButton(icon = "T", toolName = "text", selectedTool = selectedTool, onClick = { selectedTool = "text" })
                    AnnotationToolButton(icon = "S", toolName = "shape", selectedTool = selectedTool, onClick = { selectedTool = "shape" })
                }
            }
        }
    }
}

@Composable
fun AnnotationToolButton(icon: String, toolName: String, selectedTool: String, onClick: () -> Unit) {
    val isSelected = toolName == selectedTool
    Button(
        onClick = onClick,
        modifier = Modifier.size(40.dp),
        shape = CircleShape,
        colors = ButtonDefaults.buttonColors(containerColor = if(isSelected) AppTokens.Colors.secondary else AppTokens.Colors.surfaceVariant),
        contentPadding = PaddingValues(0.dp)
    ) {
        Text(icon, fontWeight = FontWeight.Bold, color = if(isSelected) AppTokens.Colors.onSecondary else AppTokens.Colors.onSurface)
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, widthDp = 720, heightDp = 1280)
@Composable
fun DefaultPreview() {
    AppTheme {
        RootScreen()
    }
}