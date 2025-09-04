import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BackendTestService } from '../../services/backend-test.service';

interface EndpointTest {
  name: string;
  url: string;
  status: 'success' | 'error' | 'pending';
  data?: any;
  error?: string;
  count?: number;
}

@Component({
  selector: 'app-diagnostico',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="diagnostico-container">
      <h1>Diagnóstico de Conexión Backend</h1>
      
      <div class="backend-info">
        <h2>Información del Backend</h2>
        <p><strong>URL Base:</strong> {{ backendInfo.baseUrl }}</p>
        <p><strong>Versión:</strong> {{ backendInfo.version }}</p>
      </div>

      <div class="connection-test">
        <h2>Test de Conexión</h2>
        <button (click)="testConnection()" [disabled]="testingConnection" class="test-button">
          {{ testingConnection ? 'Probando...' : 'Probar Conexión' }}
        </button>
        
        <div *ngIf="connectionResult" class="connection-result" 
             [class.success]="connectionResult.connected" 
             [class.error]="!connectionResult.connected">
          <p>{{ connectionResult.message }}</p>
        </div>
      </div>

      <div class="endpoints-test">
        <h2>Test de Endpoints</h2>
        <button (click)="testAllEndpoints()" [disabled]="testingEndpoints" class="test-button">
          {{ testingEndpoints ? 'Probando...' : 'Probar Todos los Endpoints' }}
        </button>

        <div *ngIf="endpointResults.length > 0" class="endpoints-results">
          <h3>Resultados:</h3>
          <div class="results-summary">
            <span class="success-count">✓ {{ successCount }} exitosos</span>
            <span class="error-count">✗ {{ errorCount }} con errores</span>
          </div>
          
          <div class="endpoint-list">
            <div *ngFor="let result of endpointResults" class="endpoint-result"
                 [class.success]="result.status === 'success'"
                 [class.error]="result.status === 'error'">
              <div class="endpoint-header">
                <span class="endpoint-name">{{ result.name }}</span>
                <span class="endpoint-status" [class.success]="result.status === 'success'">
                  {{ result.status === 'success' ? '✓' : '✗' }}
                </span>
              </div>
              <div class="endpoint-details">
                <p><strong>URL:</strong> {{ result.url }}</p>
                <p *ngIf="result.count !== undefined"><strong>Registros:</strong> {{ result.count }}</p>
                <p *ngIf="result.error" class="error-message"><strong>Error:</strong> {{ result.error }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="instructions">
        <h2>Instrucciones</h2>
        <div class="instruction-box">
          <h3>Para ejecutar el backend Django:</h3>
          <ol>
            <li>Abre una terminal en la carpeta <code>backendCoformacion</code></li>
            <li>Ejecuta: <code>python manage.py runserver</code></li>
            <li>Verifica que el servidor esté ejecutándose en <code>http://127.0.0.1:8000</code></li>
            <li>Presiona "Probar Conexión" para verificar</li>
          </ol>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .diagnostico-container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }

    h1 {
      color: #333;
      text-align: center;
      margin-bottom: 30px;
    }

    h2 {
      color: #2c3e50;
      border-bottom: 2px solid #3498db;
      padding-bottom: 5px;
    }

    .backend-info, .connection-test, .endpoints-test, .instructions {
      background: #f8f9fa;
      padding: 20px;
      margin-bottom: 20px;
      border-radius: 8px;
      border-left: 4px solid #3498db;
    }

    .test-button {
      background: #3498db;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
      margin-bottom: 15px;
    }

    .test-button:hover:not(:disabled) {
      background: #2980b9;
    }

    .test-button:disabled {
      background: #bdc3c7;
      cursor: not-allowed;
    }

    .connection-result {
      padding: 10px;
      border-radius: 5px;
      margin-top: 10px;
    }

    .connection-result.success {
      background: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }

    .connection-result.error {
      background: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }

    .results-summary {
      margin-bottom: 20px;
      padding: 10px;
      background: white;
      border-radius: 5px;
    }

    .success-count {
      color: #27ae60;
      font-weight: bold;
      margin-right: 20px;
    }

    .error-count {
      color: #e74c3c;
      font-weight: bold;
    }

    .endpoint-result {
      background: white;
      margin-bottom: 10px;
      padding: 15px;
      border-radius: 5px;
      border-left: 4px solid #95a5a6;
    }

    .endpoint-result.success {
      border-left-color: #27ae60;
    }

    .endpoint-result.error {
      border-left-color: #e74c3c;
    }

    .endpoint-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }

    .endpoint-name {
      font-weight: bold;
      font-size: 16px;
    }

    .endpoint-status {
      font-size: 18px;
      font-weight: bold;
    }

    .endpoint-status.success {
      color: #27ae60;
    }

    .endpoint-details p {
      margin: 5px 0;
      font-size: 14px;
    }

    .error-message {
      color: #e74c3c;
    }

    .instruction-box {
      background: white;
      padding: 15px;
      border-radius: 5px;
      border: 1px solid #ddd;
    }

    .instruction-box h3 {
      margin-top: 0;
      color: #2c3e50;
    }

    .instruction-box ol {
      margin: 10px 0;
    }

    .instruction-box li {
      margin-bottom: 8px;
    }

    code {
      background: #f1f2f6;
      padding: 2px 6px;
      border-radius: 3px;
      font-family: 'Courier New', monospace;
    }
  `]
})
export class DiagnosticoComponent implements OnInit {
  backendInfo = { baseUrl: '', version: '' };
  connectionResult: { connected: boolean, message: string } | null = null;
  endpointResults: EndpointTest[] = [];
  testingConnection = false;
  testingEndpoints = false;

  constructor(private backendTestService: BackendTestService) { }

  ngOnInit() {
    this.backendInfo = this.backendTestService.getBackendInfo();
  }

  testConnection() {
    this.testingConnection = true;
    this.connectionResult = null;
    
    this.backendTestService.testBackendConnection().subscribe({
      next: (result) => {
        this.connectionResult = result;
        this.testingConnection = false;
      },
      error: (error) => {
        this.connectionResult = {
          connected: false,
          message: 'Error inesperado: ' + error.message
        };
        this.testingConnection = false;
      }
    });
  }

  testAllEndpoints() {
    this.testingEndpoints = true;
    this.endpointResults = [];
    
    this.backendTestService.testAllEndpoints().subscribe({
      next: (results) => {
        this.endpointResults = results;
        this.testingEndpoints = false;
      },
      error: (error) => {
        console.error('Error testing endpoints:', error);
        this.testingEndpoints = false;
      }
    });
  }

  get successCount(): number {
    return this.endpointResults.filter(r => r.status === 'success').length;
  }

  get errorCount(): number {
    return this.endpointResults.filter(r => r.status === 'error').length;
  }
} 