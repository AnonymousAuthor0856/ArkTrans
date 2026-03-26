package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.animation.core.FastOutSlowInEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
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
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        // Immersive Mode: Hide System Bars
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            ZenBreatherTheme {
                // Ensure the status bar area is white or transparent
                SideEffect {
                    window.statusBarColor = android.graphics.Color.WHITE
                    window.navigationBarColor = android.graphics.Color.WHITE
                }
                MainScreen()
            }
        }
    }
}

// --------------------------------------------------------------------------------
// Theme & Colors
// --------------------------------------------------------------------------------

val PureWhite = Color(0xFFFFFFFF)
val TextDark = Color(0xFF2D2D2D)
val AccentTeal = Color(0xFF00897B)
val LightGray = Color(0xFFF5F5F5)

@Composable
fun ZenBreatherTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = androidx.compose.material3.lightColorScheme(
            background = PureWhite,
            surface = PureWhite,
            primary = AccentTeal,
            onBackground = TextDark,
            onSurface = TextDark
        ),
        content = content
    )
}

// --------------------------------------------------------------------------------
// Main Screen Structure
// --------------------------------------------------------------------------------

@Composable
fun MainScreen() {
    // State for selected breathing pattern
    var selectedPatternIndex by remember { mutableStateOf(0) }
    val patterns = listOf(
        BreathingPattern("Relax", 4, 6),
        BreathingPattern("Balance", 5, 5),
        BreathingPattern("Focus", 4, 4)
    )
    val currentPattern = patterns[selectedPatternIndex]

    // Animation State
    var isPlaying by remember { mutableStateOf(false) }

    Scaffold(
        containerColor = PureWhite,
        contentColor = TextDark,
        bottomBar = {
            // Minimalist Control Bar
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(32.dp),
                horizontalArrangement = Arrangement.Center
            ) {
                PlayPauseButton(
                    isPlaying = isPlaying,
                    onClick = { isPlaying = !isPlaying }
                )
            }
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .padding(horizontal = 24.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(modifier = Modifier.height(48.dp))

            // Header
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = "ZenBreather",
                    fontSize = 28.sp,
                    fontWeight = FontWeight.Bold,
                    letterSpacing = (-1).sp
                )
                Icon(
                    imageVector = Icons.Default.Settings,
                    contentDescription = "Settings",
                    tint = Color.Gray,
                    modifier = Modifier.size(24.dp)
                )
            }

            Spacer(modifier = Modifier.height(60.dp))

            // Visualizer Section
            Box(
                contentAlignment = Alignment.Center,
                modifier = Modifier.size(280.dp)
            ) {
                BreathVisualizer(isPlaying = isPlaying, durationSum = currentPattern.totalDuration)
                
                // Text inside the circle
                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                    Text(
                        text = if (isPlaying) "Breathe" else "Ready",
                        fontSize = 24.sp,
                        color = AccentTeal,
                        fontWeight = FontWeight.Medium
                    )
                    Text(
                        text = "${currentPattern.inhale}s In / ${currentPattern.exhale}s Out",
                        fontSize = 14.sp,
                        color = Color.Gray
                    )
                }
            }

            Spacer(modifier = Modifier.weight(1f))

            // Pattern Selection
            Text(
                text = "Select Rhythm",
                fontSize = 16.sp,
                fontWeight = FontWeight.SemiBold,
                modifier = Modifier.fillMaxWidth()
            )
            Spacer(modifier = Modifier.height(16.dp))
            
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                patterns.forEachIndexed { index, pattern ->
                    PatternCard(
                        pattern = pattern,
                        isSelected = index == selectedPatternIndex,
                        onClick = {
                            selectedPatternIndex = index
                            isPlaying = false // Reset on change
                        }
                    )
                }
            }
            
            Spacer(modifier = Modifier.height(32.dp))
        }
    }
}

// --------------------------------------------------------------------------------
// Components
// --------------------------------------------------------------------------------

data class BreathingPattern(val name: String, val inhale: Int, val exhale: Int) {
    val totalDuration: Int get() = inhale + exhale
}

@Composable
fun BreathVisualizer(isPlaying: Boolean, durationSum: Int) {
    val infiniteTransition = rememberInfiniteTransition(label = "breath")
    
    // Scale animation simulates lungs expanding/contracting
    val scale by infiniteTransition.animateFloat(
        initialValue = 0.8f,
        targetValue = if (isPlaying) 1.2f else 0.8f,
        animationSpec = infiniteRepeatable(
            animation = tween(durationMillis = durationSum * 1000, easing = FastOutSlowInEasing),
            repeatMode = RepeatMode.Reverse
        ),
        label = "scale"
    )

    // Rotation animation for a zen feel
    val rotation by infiniteTransition.animateFloat(
        initialValue = 0f,
        targetValue = if (isPlaying) 360f else 0f,
        animationSpec = infiniteRepeatable(
            animation = tween(durationMillis = 20000, easing = androidx.compose.animation.core.LinearEasing),
            repeatMode = RepeatMode.Restart
        ),
        label = "rotation"
    )

    Canvas(modifier = Modifier
        .fillMaxSize()
        .graphicsLayer {
            scaleX = if (isPlaying) scale else 1f
            scaleY = if (isPlaying) scale else 1f
            rotationZ = if (isPlaying) rotation else 0f
        }
    ) {
        val center = Offset(size.width / 2, size.height / 2)
        val radius = size.minDimension / 2.5f

        // Draw outer distinctive circle rings
        drawCircle(
            color = AccentTeal.copy(alpha = 0.1f),
            radius = radius,
            center = center
        )

        drawCircle(
            color = AccentTeal,
            radius = radius,
            center = center,
            style = Stroke(width = 4f)
        )

        // Draw decorative abstract shapes (Petals)
        val petalCount = 8
        val angleStep = 360f / petalCount

        for (i in 0 until petalCount) {
            val angle = i * angleStep
            val rad = Math.toRadians(angle.toDouble())
            val endX = center.x + radius * 0.7f * Math.cos(rad).toFloat()
            val endY = center.y + radius * 0.7f * Math.sin(rad).toFloat()

            // Draw a line/petal from center
            drawLine(
                color = AccentTeal.copy(alpha = 0.4f),
                start = center,
                end = Offset(endX, endY),
                strokeWidth = 2f,
                cap = StrokeCap.Round
            )
            
            // Draw small dots at ends
            drawCircle(
                color = AccentTeal,
                radius = 6f,
                center = Offset(endX, endY)
            )
        }
    }
}

@Composable
fun PatternCard(
    pattern: BreathingPattern,
    isSelected: Boolean,
    onClick: () -> Unit
) {
    val borderColor = if (isSelected) AccentTeal else Color.Transparent
    val backgroundColor = if (isSelected) AccentTeal.copy(alpha = 0.05f) else LightGray

    Box(
        modifier = Modifier
            .width(100.dp)
            .height(90.dp)
            .clip(RoundedCornerShape(20.dp))
            .background(backgroundColor)
            .border(2.dp, borderColor, RoundedCornerShape(20.dp))
            .clickable { onClick() }
            .padding(12.dp),
        contentAlignment = Alignment.Center
    ) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            if (isSelected) {
                Icon(
                    imageVector = Icons.Default.Check,
                    contentDescription = null,
                    tint = AccentTeal,
                    modifier = Modifier.size(16.dp)
                )
                Spacer(modifier = Modifier.height(4.dp))
            }
            Text(
                text = pattern.name,
                fontWeight = FontWeight.Bold,
                fontSize = 14.sp,
                color = if(isSelected) AccentTeal else TextDark
            )
            Text(
                text = "${pattern.inhale}-${pattern.exhale}",
                fontSize = 12.sp,
                color = Color.Gray
            )
        }
    }
}

@Composable
fun PlayPauseButton(
    isPlaying: Boolean,
    onClick: () -> Unit
) {
    Button(
        onClick = onClick,
        modifier = Modifier
            .height(64.dp)
            .fillMaxWidth(),
        shape = RoundedCornerShape(32.dp),
        colors = ButtonDefaults.buttonColors(
            containerColor = TextDark,
            contentColor = Color.White
        ),
        elevation = ButtonDefaults.buttonElevation(0.dp)
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Text(
                text = if (isPlaying) "STOP SESSION" else "START BREATHING",
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
                letterSpacing = 1.sp
            )
            if (!isPlaying) {
                Spacer(modifier = Modifier.width(8.dp))
                Icon(
                    imageVector = Icons.Default.PlayArrow,
                    contentDescription = null,
                    modifier = Modifier.size(20.dp)
                )
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    ZenBreatherTheme {
        MainScreen()
    }
}