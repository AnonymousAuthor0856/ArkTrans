package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Slider
import androidx.compose.material3.SliderDefaults
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
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

private const val NAME = "007_StoryEditor_en"
private const val UI_TYPE = "Social"
private const val STYLE_THEME = "Monochrome"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF1976D2)
        val secondary = Color(0xFF607D8B)
        val tertiary = Color(0xFF757575)
        val background = Color(0xFFECEFF1)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFCFD8DC)
        val outline = Color(0xFFB0BEC5)
        val success = Color(0xFF4CAF50)
        val warning = Color(0xFFFFC107)
        val error = Color(0xFFF44336)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF263238)
        val onSurface = Color(0xFF263238)
    }

    object TypographyTokens {
        val display = TextStyle(fontSize = 36.sp, fontWeight = FontWeight.Bold, letterSpacing = (-0.5).sp)
        val headline = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.SemiBold, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium, letterSpacing = 0.1.sp)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal, letterSpacing = 0.25.sp)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium, letterSpacing = 0.5.sp)
    }

    object Shapes {
        val small = RoundedCornerShape(4.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(12.dp)
    }

    object Spacing {
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
    }

    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)

    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 3.dp, 1.dp, 0.1f)
        val level2 = ShadowSpec(3.dp, 6.dp, 2.dp, 0.1f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    secondary = AppTokens.Colors.secondary,
    tertiary = AppTokens.Colors.tertiary,
    background = AppTokens.Colors.background,
    surface = AppTokens.Colors.surface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    onPrimary = AppTokens.Colors.onPrimary,
    onSecondary = AppTokens.Colors.onSecondary,
    onTertiary = AppTokens.Colors.onTertiary,
    onBackground = AppTokens.Colors.onBackground,
    onSurface = AppTokens.Colors.onSurface,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
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

data class StoryLayer(val id: Int, val type: String, val content: String)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    var textOpacity by remember { mutableFloatStateOf(1f) }
    var uploadProgress by remember { mutableFloatStateOf(0.65f) }
    val layers = remember {
        listOf(
            StoryLayer(1, "BG", "Gradient"),
            StoryLayer(2, "IMG", "User Photo"),
            StoryLayer(3, "TXT", "Hello World"),
            StoryLayer(4, "ICO", "Sticker")
        )
    }
    var selectedLayer by remember { mutableIntStateOf(layers[2].id) }

    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Story Editor", style = MaterialTheme.typography.titleMedium) },
                navigationIcon = {
                    Button(
                        onClick = {},
                        colors = ButtonDefaults.buttonColors(containerColor = Color.Transparent, contentColor = AppTokens.Colors.onBackground),
                        modifier = Modifier.padding(horizontal = AppTokens.Spacing.sm)
                    ) {
                        Text("Exit")
                    }
                },
                actions = {
                     Button(
                        onClick = {},
                        colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary),
                         shape = AppTokens.Shapes.medium,
                         modifier = Modifier.padding(horizontal = AppTokens.Spacing.sm)
                    ) {
                        Text("Post")
                    }
                },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.surface)
            )
        },
        bottomBar = {
            Surface(
                color = AppTokens.Colors.surface,
                tonalElevation = AppTokens.ElevationMapping.level2.elevation,
                shadowElevation = AppTokens.ElevationMapping.level2.elevation
            ) {
                Column(modifier = Modifier.padding(AppTokens.Spacing.lg)) {
                    Text("Layer Properties", style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.secondary)
                    Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Text("Opacity", style = MaterialTheme.typography.bodyMedium, modifier = Modifier.width(80.dp))
                        Slider(
                            value = textOpacity,
                            onValueChange = { textOpacity = it },
                            modifier = Modifier.weight(1f),
                            colors = SliderDefaults.colors(
                                thumbColor = AppTokens.Colors.primary,
                                activeTrackColor = AppTokens.Colors.primary,
                                inactiveTrackColor = AppTokens.Colors.surfaceVariant
                            )
                        )
                    }
                }
            }
        },
        containerColor = AppTokens.Colors.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(1f)
                    .padding(AppTokens.Spacing.lg),
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.tertiary),
                elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation)
            ) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text(
                        text = "Your Story Preview",
                        style = MaterialTheme.typography.headlineMedium,
                        color = AppTokens.Colors.onTertiary.copy(alpha = textOpacity),
                        textAlign = TextAlign.Center
                    )
                }
            }

            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = AppTokens.Spacing.lg),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
            ) {
                Text( "Upload Status", style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.secondary)
                LinearProgressIndicator(
                    progress = { uploadProgress },
                    modifier = Modifier.fillMaxWidth().height(AppTokens.Spacing.sm),
                    color = AppTokens.Colors.success,
                    trackColor = AppTokens.Colors.surfaceVariant
                )
            }

            LazyRow(
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                modifier = Modifier.fillMaxWidth(),
                contentPadding = androidx.compose.foundation.layout.PaddingValues(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md)
            ) {
                items(layers) { layer ->
                    val isSelected = layer.id == selectedLayer
                    Card(
                        onClick = { selectedLayer = layer.id },
                        shape = AppTokens.Shapes.medium,
                        colors = CardDefaults.cardColors(containerColor = if(isSelected) AppTokens.Colors.primary else AppTokens.Colors.surface),
                        modifier = Modifier.border(
                            width = 1.dp,
                            color = if(isSelected) AppTokens.Colors.primary else AppTokens.Colors.outline,
                            shape = AppTokens.Shapes.medium
                        )
                    ) {
                        Column(
                            modifier = Modifier.padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md).width(100.dp),
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                        ) {
                             Box(
                                modifier = Modifier.size(32.dp).background(if(isSelected) AppTokens.Colors.onPrimary.copy(alpha=0.2f) else AppTokens.Colors.surfaceVariant, CircleShape)
                            )
                            Text(layer.type, style = MaterialTheme.typography.labelMedium, color = if(isSelected) AppTokens.Colors.onPrimary else AppTokens.Colors.onSurface.copy(alpha = 0.7f))
                            Text(layer.content, style = MaterialTheme.typography.bodyMedium, color = if(isSelected) AppTokens.Colors.onPrimary else AppTokens.Colors.onSurface)
                        }
                    }
                }
            }
        }
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

@Preview(showBackground = true, backgroundColor = 0xFFECEFF1)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
